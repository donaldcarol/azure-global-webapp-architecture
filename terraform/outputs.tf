output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

 output "application_gateway_public_ip" {
  value = azurerm_public_ip.appgw_pip.ip_address
 }

output "frontdoor_endpoint" {
  value = azurerm_cdn_frontdoor_endpoint.fd_endpoint.host_name
}