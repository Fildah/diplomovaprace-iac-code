# Vystupy pro Application gateway

output "appgw_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}
