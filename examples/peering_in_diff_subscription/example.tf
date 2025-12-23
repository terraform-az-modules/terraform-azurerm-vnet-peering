provider "azurerm" {
  features {}
  # subscription_id = ""
}

provider "azurerm" {
  features {}
  alias           = "peer"
  # subscription_id = "" #change this to other subscription if dns hosted in other subscription.
}

locals {
  name        = "app1"
  environment = "test"
  label_order = ["name", "environment", "location"]
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group_1" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.3"
  name        = local.name
  environment = local.environment
  label_order = local.label_order
  location    = "northeurope"
}

##-----------------------------------------------------------------------------
## Resource Group module call - remote
##-----------------------------------------------------------------------------
module "resource_group_2" {
  providers = {
    azurerm = azurerm.peer
  }
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.3"
  name        = "app2"
  environment = local.environment
  label_order = local.label_order
  location    = "eastus"
}

##-----------------------------------------------------------------------------
## Virtual Network module call.
##-----------------------------------------------------------------------------
module "vnet" {
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.3"
  name                = local.name
  environment         = local.environment
  label_order         = local.label_order
  resource_group_name = module.resource_group_1.resource_group_name
  location            = module.resource_group_1.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

##-----------------------------------------------------------------------------
## Virtual Network module call - remote.
##-----------------------------------------------------------------------------

module "vnet_remote" {
  providers = {
    azurerm = azurerm.peer
  }
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.3"
  name                = "remote"
  environment         = local.environment
  label_order         = local.label_order
  resource_group_name = module.resource_group_2.resource_group_name
  location            = module.resource_group_2.resource_group_location
  address_spaces      = ["20.0.0.0/16"]
}

##-----------------------------------------------------------------------------
## Vent peering module call - diff subscription
##-----------------------------------------------------------------------------
module "vnet_peering" {
  source                        = "../.."
  enabled_diff_subs_peering     = true
  resource_group_1_name         = module.resource_group_1.resource_group_name
  diff_subs_resource_group_name = module.resource_group_2.resource_group_name
  providers = {
    azurerm      = azurerm
    azurerm.peer = azurerm.peer
  }
  vnet_1_name         = module.vnet.vnet_name
  vnet_1_id           = module.vnet.vnet_id
  vnet_diff_subs_name = module.vnet_remote.vnet_name
  vnet_diff_subs_id   = module.vnet_remote.vnet_id
}