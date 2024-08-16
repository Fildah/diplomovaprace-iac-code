# Definice promenych pro apliakacni vnet

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "app_rg_appgw"
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

variable "subnet_name" {
  description = "Nazev subnetu"
  type        = string
  default     = "app_subnet_c_appgw"
}

variable "subnet_address_prefixes" {
  description = "Adresni prefixy subnetu"
  type        = list(string)
  default     = ["10.200.2.32/27"]
}

variable "public_ip_name" {
  description = "Nazev verejne IP"
  type        = string
  default     = "app_appgw_pubip"
}

variable "appgw_name" {
  description = "Nazev application gateway"
  type        = string
  default     = "app-appgw"
}