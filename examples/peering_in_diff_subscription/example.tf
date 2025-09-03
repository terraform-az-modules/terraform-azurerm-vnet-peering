provider "azurerm" {
  features {}
  subscription_id = ""
}

provider "azurerm" {
  features {}
  alias           = "peer"
  subscription_id = "" #change this to other subscription if dns hosted in other subscription.
}

locals {
  name        = "app"
  environment = "test"
  label_order = ["name", "environment", "location"]
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azure"
  version     = "1.0.0"
  name        = local.name
  environment = local.environment
  label_order = local.label_order
  location    = "northeurope"
}

##-----------------------------------------------------------------------------
## Virtual Network module call.
##-----------------------------------------------------------------------------
module "vnet" {
  source              = "terraform-az-modules/vnet/azure"
  version             = "1.0.0"
  name                = local.name
  environment         = local.environment
  label_order         = local.label_order
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

data "azurerm_resource_group" "peer-rg" {
  provider = azurerm.peer
  name     = "example-rg"
}

data "azurerm_virtual_network" "peer-staging-vnet" {
  provider            = azurerm.peer
  name                = "example-vnet"
  resource_group_name = data.azurerm_resource_group.peer-rg.name
}

##-----------------------------------------------------------------------------
## Vent peering module call - diff subscription
##-----------------------------------------------------------------------------
module "vnet_peering" {
  source                        = "../.."
  enabled_diff_subs_peering     = true
  resource_group_1_name         = module.resource_group.resource_group_name
  diff_subs_resource_group_name = data.azurerm_resource_group.peer-rg.name

  providers = {
    azurerm      = azurerm
    azurerm.peer = azurerm.peer
  }
  vnet_1_name         = module.vnet.vnet_name
  vnet_1_id           = module.vnet.vnet_id
  vnet_diff_subs_name = data.azurerm_virtual_network.peer-staging-vnet.name
  vnet_diff_subs_id   = data.azurerm_virtual_network.peer-staging-vnet.id
}