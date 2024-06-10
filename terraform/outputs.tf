output "users_ids" {
  value = [for user in azuread_user.this : user.object_id]
  description = "The object IDs of the users"
}

output "dev_center_uri" {
  value = azurerm_dev_center.this.dev_center_uri
  description = "The URI of the Dev Center"
}
