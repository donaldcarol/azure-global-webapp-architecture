variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-global-webapp-demo"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "vnet-global-webapp-demo"
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "subnet_appgw_prefix" {
  description = "Application Gateway subnet"
  type        = string
  default     = "10.20.1.0/24"
}

variable "subnet_vmss_prefix" {
  description = "VMSS subnet"
  type        = string
  default     = "10.20.2.0/24"
}

variable "vmss_name" {
  description = "VM Scale Set name"
  type        = string
  default     = "vmss-web"
}

variable "admin_username" {
  description = "Admin username"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

variable "instance_count" {
  description = "Initial VMSS instance count"
  type        = number
  default     = 2
}