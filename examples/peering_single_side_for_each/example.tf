provider "azurerm" {
  features {}
  # subscription_id = "" # spoke subscription
}

provider "azurerm" {
  features {}
  alias = "hub"
  # subscription_id = "" # hub subscription
}

locals {
  environment = "test"
  label_order = ["name", "environment", "location"]

  # One hub and one spoke per region. Adding a region is one new entry.
  regions = {
    westus3 = { hub = "10.10.4.0/22", spoke = "172.21.0.0/18" }
    eastus2 = { hub = "10.20.4.0/22", spoke = "172.21.64.0/18" }
  }
}

module "resource_group_hub" {
  providers   = { azurerm = azurerm.hub }
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.4"
  for_each    = local.regions
  name        = "hub"
  environment = local.environment
  label_order = local.label_order
  location    = each.key
}

module "resource_group_spoke" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.4"
  for_each    = local.regions
  name        = "spoke"
  environment = local.environment
  label_order = local.label_order
  location    = each.key
}

module "vnet_hub" {
  providers           = { azurerm = azurerm.hub }
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.4"
  for_each            = local.regions
  name                = "hub"
  environment         = local.environment
  label_order         = local.label_order
  resource_group_name = module.resource_group_hub[each.key].resource_group_name
  location            = each.key
  address_spaces      = [each.value.hub]
}

module "vnet_spoke" {
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.4"
  for_each            = local.regions
  name                = "spoke"
  environment         = local.environment
  label_order         = local.label_order
  resource_group_name = module.resource_group_spoke[each.key].resource_group_name
  location            = each.key
  address_spaces      = [each.value.spoke]
}

##-----------------------------------------------------------------------------
## One side per call, each on the provider of that side's subscription. The
## submodule needs no provider alias, so both calls can use for_each.
##-----------------------------------------------------------------------------
module "peering_spoke_to_hub" {
  source   = "../../modules/single"
  for_each = local.regions

  name                      = "spoke-to-hub"
  resource_group_name       = module.resource_group_spoke[each.key].resource_group_name
  virtual_network_name      = module.vnet_spoke[each.key].vnet_name
  remote_virtual_network_id = module.vnet_hub[each.key].vnet_id
  allow_forwarded_traffic   = true
}

module "peering_hub_to_spoke" {
  providers = { azurerm = azurerm.hub }
  source    = "../../modules/single"
  for_each  = local.regions

  name                      = "hub-to-spoke"
  resource_group_name       = module.resource_group_hub[each.key].resource_group_name
  virtual_network_name      = module.vnet_hub[each.key].vnet_name
  remote_virtual_network_id = module.vnet_spoke[each.key].vnet_id
  allow_forwarded_traffic   = true
}
