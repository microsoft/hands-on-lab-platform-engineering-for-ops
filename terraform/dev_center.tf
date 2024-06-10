resource "azurerm_dev_center" "this" {
  name                = format("dvc-%s", local.resource_suffix_kebabcase)
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azapi_resource" "dev_center_environment_types" {
  for_each  = local.dev_center_environment_types
  type      = "Microsoft.DevCenter/devcenters/environmentTypes@2023-04-01"
  name      = each.key
  parent_id = azurerm_dev_center.this.id
  tags      = local.tags
  body = jsonencode({
    properties = {}
  })
}
