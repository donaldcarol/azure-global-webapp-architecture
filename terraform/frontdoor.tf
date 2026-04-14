# Front Door Profile
resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  name                = "fd-profile-demo"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard_AzureFrontDoor"
}

# Front Door Endpoint
resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  name                     = "fd-endpoint-demo"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
}

# Origin Group
resource "azurerm_cdn_frontdoor_origin_group" "fd_origin_group" {
  name                     = "fd-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    interval_in_seconds = 30
    path                = "/"
    protocol            = "Http"
    request_type        = "GET"
  }
}

# Origin (App Gateway)
resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  name                          = "appgw-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fd_origin_group.id
  certificate_name_check_enabled = false

  host_name          = azurerm_public_ip.appgw_pip.ip_address
  origin_host_header = azurerm_public_ip.appgw_pip.ip_address

  http_port  = 80
  https_port = 443

  enabled = true
}

# Route
resource "azurerm_cdn_frontdoor_route" "fd_route" {
  name                          = "fd-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fd_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fd_origin_group.id
  cdn_frontdoor_origin_ids = [
    azurerm_cdn_frontdoor_origin.fd_origin.id
  ]

  https_redirect_enabled = false
  supported_protocols = ["Http"]
  patterns_to_match   = ["/*"]

  forwarding_protocol = "MatchRequest"
}