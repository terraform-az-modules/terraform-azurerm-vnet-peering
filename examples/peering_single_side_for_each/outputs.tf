##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "spoke_to_hub_peering_ids" {
  value       = { for k, p in module.peering_spoke_to_hub : k => p.id }
  description = "Map of region to the id of the peering on the spoke virtual network."
}

output "hub_to_spoke_peering_ids" {
  value       = { for k, p in module.peering_hub_to_spoke : k => p.id }
  description = "Map of region to the id of the peering on the hub virtual network."
}
