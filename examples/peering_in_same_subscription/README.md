<!-- BEGIN_TF_DOCS -->

# Azure VNET Peering Example

This example demonstrates how to use Terraform modules to create Azure resource groups, virtual networks, and establish VNET peering.

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

| Name                | Source                                      | Version |
|---------------------|---------------------------------------------|---------|
| resource_group_1    | terraform-az-modules/resource-group/azure   | 1.0.0   |
| resource_group_2    | terraform-az-modules/resource-group/azure   | 1.0.0   |
| vnet                | terraform-az-modules/vnet/azure             | 1.0.0   |
| vnet_peering        | ../..                                       | n/a     |
| vnet_remote         | terraform-az-modules/vnet/azure             | 1.0.0   |

---

## 🏗️ Resources

No additional resources are directly created in this example.

---

## 🔧 Inputs

_No input variables are defined in this example._

---

## 📤 Outputs

| Name                  | Description                                                           |
|-----------------------|-----------------------------------------------------------------------|
| `vnet_peer_1_id`      | The ID of the newly created virtual network peering on the first VNET |
| `vnet_peer_1_name`    | The name of the virtual network peering on the first VNET             |
| `vnet_peer_2_id`      | The ID of the newly created virtual network peering on the second VNET|
| `vnet_peer_2_name`    | The name of the virtual network peering on the second VNET            |

<!-- END_TF_DOCS -->
