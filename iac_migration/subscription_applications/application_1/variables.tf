# Definice promenych pro Aplikace 1

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "app_app1"
}

variable "kv_name" {
  description = "Nazev Key Vault"
  type        = string
  default     = "app-app1-kv"
}

variable "acr_name" {
  description = "Nazev Container registry"
  type        = string
  default     = "acrapp1"
}