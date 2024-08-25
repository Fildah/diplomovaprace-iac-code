# vNET pro aplikace

# Resource group pro vNET
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Virtualni sit
resource "azurerm_virtual_network" "app_vnet" {
  name                = var.app_vnet_name
  address_space       = var.app_vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet A
resource "azurerm_subnet" "subnet_a" {
  name                 = var.subnet_a_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = var.subnet_a_address_prefixes
}

# Subnet B
resource "azurerm_subnet" "subnet_b" {
  name                 = var.subnet_b_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = var.subnet_b_address_prefixes
}