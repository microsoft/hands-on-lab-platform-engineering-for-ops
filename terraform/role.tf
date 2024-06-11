resource "azurerm_role_assignment" "dev_center" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Owner"
  principal_id         = azurerm_dev_center.this.identity[0].principal_id
}

resource "azurerm_role_assignment" "dev_center_key_vault_secret_user" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_dev_center.this.identity[0].principal_id
}

resource "azurerm_role_assignment" "users_key_vault_secret_user" {
  for_each             = local.users_index
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azuread_user.this[each.key].id
}