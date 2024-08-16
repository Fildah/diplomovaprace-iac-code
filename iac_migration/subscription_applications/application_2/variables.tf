# Definice promenych pro apliakacni vnet

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "app_app2"
}

variable "app_service_plan_name" {
  description = "Nazev App service plan"
  type        = string
  default     = "app-app2-appserviceplan"
}

variable "app_service_name_web" {
  description = "Nazev App service webu"
  type        = string
  default     = "app-app2-web"
}

variable "app_service_name_adm" {
  description = "Nazev App service administrace"
  type        = string
  default     = "app-app2-adm"
}

variable "mysql_server_name" {
  description = "Nazev MySQL serveru"
  type        = string
  default     = "app-app2-mysql"
}

variable "mysql_admin_username" {
  description = "Nazev uctu MySQL administratora"
  type        = string
  default     = "dbadmin"
}

variable "mysql_admin_password" {
  description = "Heslo uctu MySQL administratora"
  type        = string
  default     = "zm3n-SI-m3"
  sensitive   = true
}

variable "mysql_database_name" {
  description = "Nazev MySQL databaze"
  type        = string
  default     = "app2"
}

variable "log_app2_name" {
  description = "Nazev Log Analytics workspace pro aplikaci 2"
  type        = string
  default     = "app-app2-logAnalyticsWorkspace"
}

variable "log_app2_sku" {
  description = "SKU pro aplikaci 2 Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_app2_retention" {
  description = "Uchovávání dat ve dnech pro aplikaci 2 Log Analytics workspace"
  type        = number
  default     = "30"
}