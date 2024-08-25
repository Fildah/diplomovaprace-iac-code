# Definice promenych pro MSSQL managed instance

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "app_rg_sqlmi"
}

variable "vnet_rg_name" {
  description = "Nazev resource group kde je vytvorena virtualni sit"
  type        = string
  default     = "app_rg_vnet"
}

variable "vnet_name" {
  description = "Nazev virtualni site"
  type        = string
  default     = "app_vnet"
}

variable "app_vnet_address_space" {
  description = "Adresni prostory virtualni site"
  type        = list(string)
  default     = ["10.200.0.0/21"]
}

variable "subnet_name" {
  description = "Nazev subnetu"
  type        = string
  default     = "app_subnet_c_sqlmi"
}

variable "subnet_address_prefixes" {
  description = "Adresni prefixy subnetu"
  type        = list(string)
  default     = ["10.200.2.0/27"]
}

variable "route_table_name" {
  description = "Nazev route table"
  type        = string
  default     = "routetable-sql-mi"
}

variable "sqlmi_name" {
  description = "Nazev SQL managed instance"
  type        = string
  default     = "app-sqlmi"
}

variable "sqlmi_admin_login" {
  description = "Nazev administratorskeho uctu k instanci"
  type        = string
  default     = "dbadmin"
}

variable "sqlmi_admin_pass" {
  description = "Heslo administratorskeho uctu k instanci"
  type        = string
  default     = "zm3n-SI-m3"
  sensitive   = true
}

variable "sqlmi_sku" {
  description = "SKU SQL managed instance"
  type        = string
  default     = "GP_Gen5"
}

variable "sqlmi_vcores" {
  description = "Pocet virtualnich jader SQL managed instance"
  type        = number
  default     = 4
}

variable "sqlmi_storage" {
  description = "velikost uloziste SQL managed instance"
  type        = number
  default     = 32
}

variable "sqlmi_db_name" {
  description = "Nazev databaze v SQL managed instanci"
  type        = string
  default     = "app_sql_dbname"
}



