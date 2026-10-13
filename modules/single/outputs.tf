##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "id" {
  value       = try(azurerm_virtual_network_peering.main[0].id, null)
  description = "The id of the virtual network peering."
}

output "name" {
  value       = try(azurerm_virtual_network_peering.main[0].name, null)
  description = "The name of the virtual network peering."
}
