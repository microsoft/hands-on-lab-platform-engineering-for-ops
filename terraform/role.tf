resource "azurerm_role_assignment" "dev_center" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Owner"
  principal_id         = azurerm_dev_center.this.identity[0].principal_id
}
