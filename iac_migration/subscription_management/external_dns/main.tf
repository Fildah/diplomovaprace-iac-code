# Externi DNS

# Vytvoreni resource group pro externi DNS
resource "azurerm_resource_group" "rg_extdns" {
  name     = var.rg_name
  location = var.location
}

# Vytvoreni externich DNS z listu
resource "azurerm_dns_zone" "example-public" {
  for_each            = toset(var.dns_zones)
  name                = each.value
  resource_group_name = azurerm_resource_group.rg_extdns.name
}