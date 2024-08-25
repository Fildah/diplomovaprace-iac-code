# Vytupy pro Site-to-site VPN

output "vpn_gateway_id" {
  value = azurerm_virtual_network_gateway.vpn_gateway.id
}