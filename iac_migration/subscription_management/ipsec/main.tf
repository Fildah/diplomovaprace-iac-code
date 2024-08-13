# Site-to-site VPN

# Resource group pro VPN
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Virtualni site
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Verejna IP adresa pro VPN
resource "azurerm_public_ip" "vpn_public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku = "Standard"
  zones = ["1", "2", "3"]
}

# Brana virtualni site
resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.vpn_gateway_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = var.vpn_gateway_active_active
  enable_bgp          = false
  sku                 = var.vpn_gateway_sku
  generation = "Generation2"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn_public_ip.id
    subnet_id                     = azurerm_subnet.subnet.id
  }
}

# Brana vnitrni site
resource "azurerm_local_network_gateway" "local_network_gateway" {
  name                = var.local_gateway_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  gateway_address     = var.local_gateway_publicip
  address_space       = var.local_gateway_address_space
}

# Pripojeni mezi VPN branou a branou vnitrni site
resource "azurerm_virtual_network_gateway_connection" "vpn_connection" {
  name                       = var.vpn_connection_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway.id
  type                       = "IPsec"
  connection_protocol        = "IKEv2"

  shared_key = var.vpn_connection_shared_key
}