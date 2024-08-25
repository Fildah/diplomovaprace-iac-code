# Management Logovani

# Resource group pro logovani
resource "azurerm_resource_group" "rg_logs" {
  name     = var.rg_name
  location = var.location
}

# Log Analytics pracovního prostoru Entra
resource "azurerm_log_analytics_workspace" "log_entra" {
  name                = var.log_entra_name
  location            = azurerm_resource_group.rg_logs.location
  resource_group_name = azurerm_resource_group.rg_logs.name
  sku                 = var.log_entra_sku
  retention_in_days   = var.log_entra_retention
}

# Log Analytics pracovního prostoru management logu
resource "azurerm_log_analytics_workspace" "log_mngm" {
  name                = var.log_mngm_name
  location            = azurerm_resource_group.rg_logs.location
  resource_group_name = azurerm_resource_group.rg_logs.name
  sku                 = var.log_mngm_sku
  retention_in_days   = var.log_mngm_retention
}