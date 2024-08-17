# Definice provideru Azure RM providers.tf

# Inicializace Terraform jadra
terraform {
  # Minimalni verze Terraform pozadovane providerem a zdroji
  required_version = ">= 1.0.0"

  # Pozadovani provideri
  required_providers {
    # Definice providera azurerm
    azurerm = {
      # Zdrojovy repozitar kde je provider ulozen ke stazeni
      source = "hashicorp/azurerm"
      # Pozadovana verze providera
      version = "3.114.0"
    }
  }
}

# Inicializace definovaneho providera azurerm
provider "azurerm" {
  # Definice pridanych funkci
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}