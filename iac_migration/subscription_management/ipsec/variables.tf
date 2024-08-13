# Definice promenych pro management ipsec vnet

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "management_rg_vnet"
}

variable "vnet_name" {
  description = "Nazev virtualni site"
  type        = string
  default     = "mngm_vnet"
}

variable "vnet_address_space" {
  description = "Adresni prostory virtualni site"
  type        = list(string)
  default     = ["10.200.0.0/21"]
}

variable "subnet_name" {
  description = "Nazev subnetu"
  type        = string
  default     = "GatewaySubnet"
}

variable "subnet_address_prefixes" {
  description = "Adresni prefixy subnetu"
  type        = list(string)
  default     = ["10.200.0.0/24"]
}

variable "public_ip_name" {
  description = "Nazev verejne IP adresy"
  type        = string
  default     = "mngm_publicip_primary"
}

variable "public_ip_allocation_method" {
  description = "Metoda alokace verejne IP adresy"
  type        = string
  default     = "Dynamic"
}

variable "vpn_gateway_name" {
  description = "Nazev brany virtualni site"
  type        = string
  default     = "mngm_gateway"
}

variable "vpn_gateway_active_active" {
  description = "Parametr brany virtualni site active-active nastaveni"
  type        = bool
  default     = false
}

variable "vpn_gateway_sku" {
  description = "SKU brany virtualni site"
  type        = string
  default     = "VpnGw2AZ"
}

variable "local_gateway_name" {
  description = "Nazev brany vnitrni site"
  type        = string
  default     = "ipsec_GW"
}

variable "local_gateway_publicip" {
  description = "IP adresa brany vnitrni site"
  type        = string
  default     = "188.122.122.122"
}


variable "local_gateway_address_space" {
  description = "Adresni prostory brany vnitrni site"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "vpn_connection_name" {
  description = "Nazev spojeni VPN a vnitrni site"
  type        = string
  default     = "ipsec_S2S"
}

variable "vpn_connection_shared_key" {
  description = "Klic spojeni VPN a vnitrni site"
  type        = string
  default     = "sem.vepis.svuj.klic"
}