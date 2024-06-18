# create a resource group for each user
resource "azurerm_resource_group" "rg-azurepolicy-lab" {
  for_each = local.users_index
  name     = format("rg-ms-user%s-lab-azurepolicy", each.value)
  location = var.location
}

resource "azurerm_role_assignment" "rg_azurepolicy_lab_contributor" {
  for_each             = local.users_index
  scope                = azurerm_resource_group.rg-azurepolicy-lab[each.key].id
  role_definition_name = "Contributor"
  principal_id         = azuread_user.this[each.key].id
}

resource "azapi_resource" "template-spec-azurepolicy-lab" {
  for_each = azurerm_resource_group.rg-azurepolicy-lab

  type      = "Microsoft.Resources/templateSpecs@2022-02-01"
  name      = format("ts-ms-user%s-lab-azurepolicy", each.key)
  location  = each.value.location
  parent_id = each.value.id

  body = jsonencode({
    properties = {
      description = "Template spec for Azure Policy lab",
      displayName = "AzurePolicyLabTemplateSpec",
    }
  })
}

# create a template spec for each resource group
resource "azapi_resource" "template-spec-version-azurepolicy-lab" {
  for_each = azapi_resource.template-spec-azurepolicy-lab

  type      = "Microsoft.Resources/templateSpecs/versions@2022-02-01"
  name      = format("v1.0.0-ts-ms-user%s-lab-azurepolicy", each.key)
  location  = each.value.location
  parent_id = each.value.id

  body = jsonencode({
    "properties" : {
      "description" : "Template spec for Azure Policy lab",
      "mainTemplate" : {
        "$schema" : "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
        "contentVersion" : "1.0.0.0",
        "parameters" : {
          "nsgName" : {
            "type" : "string",
            "metadata" : {
              "description" : "The name of the network security group"
            },
            "defaultValue" : "nsg-test"
          },
          "testInboundIpAddress" : {
            "type" : "string",
            "metadata" : {
              "description" : "The IP address for the test inbound rule"
            },
            "defaultValue" : "10.0.0.2"
          },
          "location" : {
            "type" : "string",
            "metadata" : {
              "description" : "The location for the resources"
            },
            "defaultValue" : "westeurope",
            "allowedValues" : ["westeurope", "northeurope"],
          }
        },
        "resources" : [
          {
            "type" : "Microsoft.Network/networkSecurityGroups",
            "apiVersion" : "2021-02-01",
            "name" : "[parameters('nsgName')]",
            "location" : "[parameters('location')]",
            "properties" : {
              "securityRules" : [
                {
                  "name" : "Rule1",
                  "properties" : {
                    "protocol" : "*",
                    "sourceAddressPrefix" : "10.0.0.1",
                    "destinationAddressPrefix" : "*",
                    "access" : "Allow",
                    "direction" : "Inbound",
                    "priority" : 100,
                    "sourcePortRange" : "*",
                    "destinationPortRange" : "*"
                  }
                },
                {
                  "name" : "Rule2",
                  "properties" : {
                    "protocol" : "*",
                    "sourceAddressPrefix" : "172.16.0.1",
                    "destinationAddressPrefix" : "*",
                    "access" : "Allow",
                    "direction" : "Inbound",
                    "priority" : 101,
                    "sourcePortRange" : "*",
                    "destinationPortRange" : "*"
                  }
                },
                {
                  "name" : "Rule3",
                  "properties" : {
                    "protocol" : "*",
                    "sourceAddressPrefix" : "192.168.1.1",
                    "destinationAddressPrefix" : "*",
                    "access" : "Allow",
                    "direction" : "Inbound",
                    "priority" : 102,
                    "sourcePortRange" : "*",
                    "destinationPortRange" : "*"
                  }
                },
                {
                  "name" : "Rule4-TestInboundIpAddress",
                  "properties" : {
                    "protocol" : "*",
                    "sourceAddressPrefix" : "[parameters('testInboundIpAddress')]",
                    "destinationAddressPrefix" : "*",
                    "access" : "Allow",
                    "direction" : "Inbound",
                    "priority" : 103,
                    "sourcePortRange" : "*",
                    "destinationPortRange" : "*"
                  }
                }
              ]
            }
          }
        ]
      }
    }
  })
}

# create a virtual network in each resource group that has 1 subnet. the address space is: 10.0.0.0/16
resource "azurerm_virtual_network" "vnet-azurepolicy-lab" {
  for_each = azurerm_resource_group.rg-azurepolicy-lab

  name                = format("vnet-ms-user%s-lab-azurepolicy", each.key)
  resource_group_name = each.value.name
  location            = each.value.location
  address_space       = ["10.0.0.0/16"]
}
