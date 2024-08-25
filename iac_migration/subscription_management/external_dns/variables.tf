# Definice promenych pro Externi DNS

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "management_rg_extdns"
}

variable "dns_zones" {
  description = "List domen"
  type        = list(string)
  default     = ["priklad.cz", "example.com"]
}