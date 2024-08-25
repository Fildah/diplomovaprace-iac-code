# Definice promenych pro Aplikace 3 variables.tf

variable "vnet_name" {
  description = "Nazev existujici virtualni site"
  type        = string
  default     = "app_vnet"
}

variable "vnet_resource_group_name" {
  description = "Nazev resource group virtualni site"
  type        = string
  default     = "app_rg_vnet"
}

variable "subnet_name" {
  description = "Nazev existujiciho subnetu"
  type        = string
  default     = "app_subnet_a"
}

variable "app_gateway_name" {
  description = "Nazev existujici application gateway"
  type        = string
  default     = "app-appgw"
}

variable "app_gateway_resource_group_name" {
  description = "Nazev resource group existujici application gateway"
  type        = string
  default     = "app_rg_appgw"
}

variable "sql_instance_name" {
  description = "Nazev existujiciho instance MS SQL Managed Instance"
  type        = string
  default     = "default-sql-instance-name"
}

variable "sql_instance_resource_group_name" {
  description = "Nazev resource group existujici MS SQL Managed Instance"
  type        = string
  default     = "app_rg_sqlmi"
}

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "app_app3"
}

variable "sqlmi_db_name" {
  description = "Nazev databaze v SQL managed instanci"
  type        = string
  default     = "app_sql_dbname"
}

variable "nsg_name" {
  description = "Nazev network security groupe"
  type        = string
  default     = "app_rg_app3_nsg"
}

variable "vm_size" {
  description = "Velikost VM"
  type        = string
  default     = "Standard_B2ms"
}

variable "vm_admin_username" {
  description = "Nazev uctu VM administratora"
  type        = string
  default     = "localadmin"
}

variable "vm_admin_password" {
  description = "Heslo uctu VM administratora"
  type        = string
  default     = "zm3n-SI-m3"
  sensitive   = true
}

variable "kv_name" {
  description = "Nazev Key Vault"
  type        = string
  default     = "app-app3-kv"
}