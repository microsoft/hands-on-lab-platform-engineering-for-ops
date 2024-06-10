data "azuread_group" "this" {
  display_name     = var.user_group_name
  security_enabled = true
}