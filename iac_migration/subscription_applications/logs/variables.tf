# Definice promenych pro Aplikacni Logovani

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "app_rg_logs"
}

variable "log_app_name" {
  description = "Nazev Log Analytics workspace pro aplikacni sluzby"
  type        = string
  default     = "app-logAnalyticsWorkspace"
}

variable "log_app_sku" {
  description = "SKU pro management Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_app_retention" {
  description = "Uchovávání dat ve dnech pro aplikacni Log Analytics workspace"
  type        = number
  default     = "30"
}