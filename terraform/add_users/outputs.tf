output "users_ids" {
  value = [for user in azuread_user.this : user.object_id]
}