##-----------------------------------------------------------------------------
## One side of a virtual network peering, on the default provider only.
## Call it once per side (each call with the provider of that side's
## subscription) to peer across subscriptions with for_each or count, which the
## root module cannot offer because it requires the azurerm.peer alias.
##-----------------------------------------------------------------------------
resource "azurerm_virtual_network_peering" "main" {
  count                        = var.enabled ? 1 : 0
  name                         = var.name
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.virtual_network_name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}
