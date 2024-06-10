data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

data "azuread_group" "this" {
  display_name     = var.user_group_name
  security_enabled = true
}