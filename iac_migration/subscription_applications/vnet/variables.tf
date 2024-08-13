# Definice promenych pro apliakacni vnet

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "app_rg_vnet"
}

variable "app_vnet_name" {
  description = "Nazev virtualni site"
  type        = string
  default     = "app_vnet"
}

variable "app_vnet_address_space" {
  description = "Adresni prostory virtualni site"
  type        = list(string)
  default     = ["10.200.0.0/21"]
}

variable "subnet_a_name" {
  description = "Nazev subnetu"
  type        = string
  default     = "app_subnet_a"
}

variable "subnet_a_address_prefixes" {
  description = "Adresni prefixy subnetu"
  type        = list(string)
  default     = ["10.200.0.0/24"]
}

variable "subnet_b_name" {
  description = "Nazev subnetu"
  type        = string
  default     = "app_subnet_b"
}

variable "subnet_b_address_prefixes" {
  description = "Adresni prefixy subnetu"
  type        = list(string)
  default     = ["10.200.1.0/24"]
}