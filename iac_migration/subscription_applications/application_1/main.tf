# Application 1 main.tf

# # Priklad import bloku k importu jiz existujici infra
# import {
#   id = "/subscriptions/ca9de45d-3452-4962-aa85-2d5463e0a2b4/resourceGroups/app_app1"
#   to = azurerm_resource_group.rg
# }

# import {
#   id = "/subscriptions/ca9de45d-3452-4962-aa85-2d5463e0a2b4/resourceGroups/app_app1/providers/Microsoft.KeyVault/vaults/app-app1-kv"
#   to = azurerm_key_vault.kv
# }

# import {
#   id = "/subscriptions/ca9de45d-3452-4962-aa85-2d5463e0a2b4/resourceGroups/app_app1/providers/Microsoft.ContainerRegistry/registries/acrapp1"
#   to = azurerm_container_registry.acr
# }

# Ziskani dat o soucasnem nastaveni clienta Azure
data "azurerm_client_config" "current" {}

# Resource group pro Application gateway
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

# Container registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}