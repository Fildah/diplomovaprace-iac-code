# Aplikace 3 main.tf

# Data o soucasnem nastaveni clienta Azure
data "azurerm_client_config" "current" {}

# Data o existujici virtualni siti
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

# Data o existujicim subnetu
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = var.vnet_name
}

# Data o existujici Application Gateway
data "azurerm_application_gateway" "app_gateway" {
  name                = var.app_gateway_name
  resource_group_name = var.app_gateway_resource_group_name
}

# Data o existující MS SQL Managed Instance
data "azurerm_mssql_managed_instance" "sql_instance" {
  name                = var.sql_instance_name
  resource_group_name = var.sql_instance_resource_group_name
}


# Resource group pro Aplikaci 3
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# MSSQL managed databaze
resource "azurerm_mssql_managed_database" "sqlmi_db" {
  managed_instance_id = data.azurerm_mssql_managed_instance.sql_instance.id
  name                = var.sqlmi_db_name

  lifecycle {
    prevent_destroy = true
  }
}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

# Network security group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = data.azurerm_virtual_network.vnet.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Network interface
resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "vm-nic-0${count.index}"
  location            = data.azurerm_virtual_network.vnet.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Asociace mezi network interface a network security group
resource "azurerm_network_interface_security_group_association" "nic_nsg_asoc" {
  count                     = 2
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Virtual machines
resource "azurerm_windows_virtual_machine" "vm" {
  count                 = 2
  name                  = "win-vm-0${count.index}"
  location              = data.azurerm_virtual_network.vnet.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.vm_size
  admin_username        = var.vm_admin_username
  admin_password        = var.vm_admin_password
  patch_mode            = "AutomaticByPlatform"
  hotpatching_enabled   = true
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition-hotpatch"
    version   = "latest"
  }
}