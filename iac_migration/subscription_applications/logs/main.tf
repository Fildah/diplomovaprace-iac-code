# Aplikacni Logovani

# Resource group pro logovani
resource "azurerm_resource_group" "rg_logs" {
  name     = var.rg_name
  location = var.location
}

# Log Analytics pracovního prostoru aplikacniho logu
resource "azurerm_log_analytics_workspace" "log_app" {
  name                = var.log_app_name
  location            = azurerm_resource_group.rg_logs.location
  resource_group_name = azurerm_resource_group.rg_logs.name
  sku                 = var.log_app_sku
  retention_in_days   = var.log_app_retention
}