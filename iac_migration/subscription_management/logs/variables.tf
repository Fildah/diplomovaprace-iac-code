# Definice promenych pro Management Logovani variables.tf

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "management_rg_logs"
}

variable "log_entra_name" {
  description = "Nazev Log Analytics workspace pro Entra"
  type        = string
  default     = "mngm-logAnalyticsWorkspace-Entra"
}

variable "log_entra_sku" {
  description = "SKU pro Entra Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_entra_retention" {
  description = "Uchovavani dat ve dnech pro Entra Log Analytics workspace"
  type        = number
  default     = "180"
}

variable "log_mngm_name" {
  description = "Nazev Log Analytics workspace pro management aplikace a sluzby"
  type        = string
  default     = "mngm-logAnalyticsWorkspace"
}

variable "log_mngm_sku" {
  description = "SKU pro management Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_mngm_retention" {
  description = "Uchovavani dat ve dnech pro Entra Log Analytics workspace"
  type        = number
  default     = "30"
}