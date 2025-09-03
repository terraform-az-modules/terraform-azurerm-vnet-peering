<!-- BEGIN_TF_DOCS -->

# Azure VNET Peering Setup

This configuration demonstrates cross-resource group VNET peering using Terraform modules and data sources.

---

## ✅ Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.6.6  |
| Azurerm   | >= 3.116.0 |

---

## 🔌 Providers

| Name          | Version |
|---------------|---------|
| azurerm.peer  | 3.116.0 |

---

## 📦 Modules

| Name            | Source                                      | Version |
|-----------------|---------------------------------------------|---------|
| resource_group  | terraform-az-modules/resource-group/azure   | 1.0.0   |
| vnet            | terraform-az-modules/vnet/azure             | 1.0.0   |
| vnet_peering    | ../..                                       | n/a     |

---

## 🏗️ Resources

| Name                         | Type        |
|------------------------------|-------------|
| azurerm_resource_group.peer-rg | data source |
| azurerm_virtual_network.peer-staging-vnet | data source |

---

## 🔧 Inputs

_No input variables are defined in this configuration._

---

## 📤 Outputs

| Name                  | Description                                                           |
|-----------------------|-----------------------------------------------------------------------|
| `vnet_peer_1_id`      | The ID of the virtual network peering on the first VNET               |
| `vnet_peer_1_name`    | The name of the virtual network peering on the first VNET             |
| `vnet_peer_2_id`      | The ID of the virtual network peering on the second VNET              |
| `vnet_peer_2_name`    | The name of the virtual network peering on the second VNET            |

<!-- END_TF_DOCS -->
