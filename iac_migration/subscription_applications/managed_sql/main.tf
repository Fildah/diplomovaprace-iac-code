# SQL managed instance
# "/subscriptions/ca9de45d-3452-4962-aa85-2d5463e0a2b4/resourceGroups/app_rg_vnet/providers/Microsoft.Network/virtualNetworks/app_vnet"

# Resource group pro SQL managed instance
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Subnet pro SQL managed instance
resource "azurerm_subnet" "subnet_a" {
  name                 = var.subnet_a_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = var.subnet_a_address_prefixes
}

resource "azurerm_sql_managed_instance" "example" {
  name                         = "example"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"
  license_type                 = "BasePrice"
  subnet_id                    = azurerm_subnet.example.id
  sku_name                     = "GP_Gen5"
  vcores                       = 4
  storage_size_in_gb           = 32
}

resource "azurerm_sql_managed_database" "example" {
  sql_managed_instance_id = azurerm_sql_managed_instance.example.id
  name                    = "exampledatabase"
  location                = azurerm_resource_group.example.location

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}