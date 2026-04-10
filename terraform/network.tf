resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
}

# Subnet pentru Application Gateway (trebuie dedicat!)
resource "azurerm_subnet" "appgw" {
  name                 = "snet-appgw"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_appgw_prefix]
}

# Subnet pentru VM Scale Set
resource "azurerm_subnet" "vmss" {
  name                 = "snet-vmss"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_vmss_prefix]
}

# NSG pentru VMSS
resource "azurerm_network_security_group" "vmss_nsg" {
  name                = "nsg-vmss"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Regula: permite HTTP din App Gateway subnet
resource "azurerm_network_security_rule" "allow_http_from_appgw" {
  name                        = "allow-http-from-appgw"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"

  # IMPORTANT: doar din subnetul AppGW
  source_address_prefix       = var.subnet_appgw_prefix
  destination_address_prefix  = "*"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.vmss_nsg.name
}

# Asociere NSG cu subnet VMSS
resource "azurerm_subnet_network_security_group_association" "vmss_assoc" {
  subnet_id                 = azurerm_subnet.vmss.id
  network_security_group_id = azurerm_network_security_group.vmss_nsg.id
}