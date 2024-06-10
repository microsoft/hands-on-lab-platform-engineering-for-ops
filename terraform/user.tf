resource "azuread_user" "this" {
  for_each            = local.users_index
  user_principal_name = "${var.owner}_user${each.key}_${var.environment}@${var.domain_name}"
  display_name        = "${title(var.owner)} User${each.key} ${title(var.environment)}"
  mail_nickname       = "user${each.key}"
  password            = var.user_default_password
  usage_location      = "FR"
  account_enabled     = var.user_account_enabled
}

resource "azuread_group_member" "this" {
  for_each         = local.users_index
  group_object_id  = data.azuread_group.this.id
  member_object_id = azuread_user.this[each.key].id
  depends_on = [
    azuread_user.this,
  ]
}
