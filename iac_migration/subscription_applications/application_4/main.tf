# Aplikace 4 main.tf

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

# Resource group pro Aplikaci 4
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
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
  count               = var.vm_count
  name                = "${var.vm_names[count.index]}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Network interface
resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "${var.vm_names[count.index]}-nic"
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
  count                     = var.vm_count
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}

# Virtual machines
resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.vm_count
  name                = var.vm_names[count.index]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_sizes[count.index]
  admin_username      = var.vm_admin_username
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    public_key = var.vm_admin_pubkey
    username   = var.vm_admin_username
  }
}

# Managed disk
resource "azurerm_managed_disk" "disk" {
  name                 = "${var.vm_names[0]}-disk1"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 20
}

# Asociace mezi VM a Managed disk
resource "azurerm_virtual_machine_data_disk_attachment" "vm_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[0].id
  lun                = "0"
  caching            = "ReadWrite"
}

# Storage account
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}