# Definice promenych pro Aplikace 4 variables.tf

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

variable "location" {
  description = "Lokalita resource group a vytvorenych zdroju"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Nazev resource group"
  type        = string
  default     = "app_app4"
}

variable "nsg_name" {
  description = "Nazev network security groupe"
  type        = string
  default     = "app_rg_app3_nsg"
}

variable "vm_count" {
  description = "Pocet VMs"
  type        = number
  default     = 3
}

variable "vm_names" {
  description = "List s jmeny VMs"
  type        = list(string)
  default     = ["vm1", "vm2", "vm3"]
}

variable "vm_sizes" {
  description = "List s velikostmi VMs"
  type        = list(string)
  default     = ["Standard_B1s", "Standard_B1s", "Standard_B1s"]
}

variable "vm_admin_username" {
  description = "Nazev uctu VM administratora"
  type        = string
  default     = "localadmin"
}

variable "vm_admin_pubkey" {
  description = "Verejny ssh klic k uctu VM administratora"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDOiINMXOYyl59zuD/XIk8OAYKFOEfpOExxtXKNZesLu7Kv3iFSsJDgAzoC94KZLgTov4NlZNT36DSLm7VlYnXLXCp6hsI8/+9o0ZbJoMFkQYEDxS6CjFlUDYkyOilch/KPJMf9TlL/t18UWq8pfl5sSDypeUFEahkwbnymH0rgODN4av70wCkKxWm78j+5+ZW22ctVfF1Nf6Z0XiCrNT6pI3PZ1Wq7n2gTJh2KxlvejJPTSoEBtLMr9zmRvRhS+L3EX9yUXSkczfCHY69PIXzV1+A1PLS43sxpl6lXAVG4awNj5lCWqtstCoDFAc5SDyPQPEzQ86LTIzjxpL8b3uHDhI5jMdbWyImHDo8BR33ezChcBU8TY7BEs6j7bqMvvwH86LHQn8ltS9qa1p4CMTRHIrk6pTJhkfD2iErWK3am7K4SSdhQjSW9Uk+bgc8OJy5ye55XEhdF7fMkGRYDkb6bIpgZ21KkCJpUE1r1E1JblXahjebDWSa1xfg8F87AYh0MByF7grfNZ0sGH9ScL+mXmkkVHfqF1xK+dfflIz1hgn5+io8mt3JreQgFlBgrBEOQpd+jqbZQUGKdyuMNvOAQRHVI5Jip5zp5DYmEcTflmlXrv4QkGLFhVT4qOg3WG4XZ3vfG/IzOjqkGKbDxvt6IitizQBjt106vf7moppw2Uw=="
}

variable "kv_name" {
  description = "Nazev Key Vault"
  type        = string
  default     = "app-app4-kv"
}

variable "storage_name" {
  description = "Nazev Storage account"
  type        = string
  default     = "appapp4storage"
}