resource "azurerm_key_vault" "this" {
  name                        = format("kv-%s", local.resource_suffix_kebabcase)
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
      "List"
    ]
  }

  dynamic "access_policy" {
    for_each = local.users_index

    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = azuread_user.this[access_policy.key].id

      secret_permissions = [
        "Get",
        "List"
      ]
    }
  }
}

resource "azurerm_key_vault_secret" "github_pat" {
  name         = "Pat"
  value        = "TO_DEFINE"
  key_vault_id = azurerm_key_vault.this.id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
