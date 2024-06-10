resource "azuread_user" "this" {
  count               = var.number_of_users
  user_principal_name = "${var.owner}_user${count.index}_${var.environment}@${var.domain_name}"
  display_name        = "${title(var.owner)} User${count.index} ${title(var.environment)}"
  mail_nickname       = "user${count.index}"
  password            = var.user_default_password
  usage_location      = "FR"
  account_enabled     = var.user_account_enabled
}

resource "azuread_group_member" "this" {
  count            = var.number_of_users
  group_object_id  = data.azuread_group.this.id
  member_object_id = azuread_user.this[count.index].id
  depends_on = [
    azuread_user.this,
  ]
}
