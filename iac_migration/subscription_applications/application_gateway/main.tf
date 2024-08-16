# Application gateway

# Resource group pro Application gateway
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Subnet pro Application gateway
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_address_prefixes
}

# Verejna IP adresa pro Application gateway
resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}

# Application gateway
resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = azurerm_subnet.subnet.id
  }

  frontend_port {
    name = "frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appgw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = "backend-pool"
  }

  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "appgw-frontend-ip"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "backend-http-settings"
  }

  waf_configuration {
    enabled              = true
    firewall_mode        = "Prevention"
    rule_set_type        = "OWASP"
    rule_set_version     = "3.2"
    file_upload_limit_mb = 100
  }
}