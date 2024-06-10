resource "azurerm_role_assignment" "dev_center" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Owner"
  principal_id         = azurerm_dev_center.this.identity[0].principal_id
}

# resource "azurerm_role_assignment" "dev_center_devbox_user" {
#   for_each             = local.users_index
#   scope                = azurerm_dev_center.this.id
#   role_definition_name = "DevCenter DevBox User"
#   principal_id         = azuread_user.this[each.key].id
# }

# resource "azurerm_role_assignment" "dev_center_project_admin" {
#   for_each             = local.users_index
#   scope                = azurerm_dev_center.this.id
#   role_definition_name = "DevCenter Project Admin"
#   principal_id         = azuread_user.this[each.key].id
# }
