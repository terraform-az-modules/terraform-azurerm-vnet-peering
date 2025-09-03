provider "azurerm" {
  features {}
  subscription_id = ""
}

provider "azurerm" {
  features {}
  alias           = "peer"
  subscription_id = "" #change this to other subscription if dns hosted in other subscription.
}

##-----------------------------------------------------------------------------
## Resource Group module call
##-----------------------------------------------------------------------------
module "resource_group_1" {
  source      = "terraform-az-modules/resource-group/azure"
  version     = "1.0.0"
  name        = "app1"
  environment = "test"
  label_order = ["name", "environment", "location"]
  location    = "northeurope"
}

##-----------------------------------------------------------------------------
## Resource Group module call - remote
##-----------------------------------------------------------------------------
module "resource_group_2" {
  source      = "terraform-az-modules/resource-group/azure"
  version     = "1.0.0"
  name        = "app2"
  environment = "test"
  label_order = ["name", "environment", "location"]
  location    = "eastus"
}

##-----------------------------------------------------------------------------
## Virtual Network module call.
##-----------------------------------------------------------------------------
module "vnet" {
  source              = "terraform-az-modules/vnet/azure"
  version             = "1.0.0"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group_1.resource_group_name
  location            = module.resource_group_1.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

##-----------------------------------------------------------------------------
## Virtual Network module call - remote.
##-----------------------------------------------------------------------------
module "vnet_remote" {
  source              = "terraform-az-modules/vnet/azure"
  version             = "1.0.0"
  name                = "remote"
  environment         = "test"
  resource_group_name = module.resource_group_2.resource_group_name
  location            = module.resource_group_2.resource_group_location
  address_spaces      = ["20.0.0.0/16"]
}

##-----------------------------------------------------------------------------
## Vent peering module call - same subscription
##-----------------------------------------------------------------------------
module "vnet_peering" {
  source          = "../.."
  enabled_peering = true
  providers = {
    azurerm      = azurerm
    azurerm.peer = azurerm.peer
  }

  resource_group_1_name = module.resource_group_1.resource_group_name
  resource_group_2_name = module.resource_group_2.resource_group_name
  different_rg          = true
  vnet_1_name           = module.vnet.vnet_name
  vnet_1_id             = module.vnet.vnet_id
  vnet_2_name           = module.vnet_remote.vnet_name
  vnet_2_id             = module.vnet_remote.vnet_id
}