##-----------------------------------------------------------------------------
## Variables
##-----------------------------------------------------------------------------
variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "name" {
  type        = string
  description = "The name of the virtual network peering. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group of the local virtual network."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the local virtual network."
}

variable "remote_virtual_network_id" {
  type        = string
  description = "The full Azure resource ID of the remote virtual network."
}

variable "allow_virtual_network_access" {
  type        = bool
  default     = true
  description = "Controls if the VMs in the remote virtual network can access VMs in the local virtual network."
}

variable "allow_forwarded_traffic" {
  type        = bool
  default     = false
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed."
}

variable "allow_gateway_transit" {
  type        = bool
  default     = false
  description = "Controls gatewayLinks can be used in the remote virtual network's link to the local virtual network."
}

variable "use_remote_gateways" {
  type        = bool
  default     = false
  description = "Controls if remote gateways can be used on the local virtual network."
}
