variable "environment" {
  description = "The environment deployed"
  type        = string
  default     = "lab"
  validation {
    condition     = can(regex("(lab|dev|stg|prd)", var.environment))
    error_message = "The environment value must be a valid."
  }
}

variable "owner" {
  description = "The name of the project's owner"
  type        = string
  default     = "ms"
}

variable "domain_name" {
  description = "The name of the Azure AD tenant"
  type        = string
  # sample: "Mng123.onmicrosoft.com"
}

variable "user_default_password" {
  description = "The user default password inside the Azure AD tenant"
  type        = string
  sensitive   = true
}

variable "user_group_name" {
  description = "The name of the user group"
  type        = string
  default     = "workshop-user-group"
}

variable "user_account_enabled" {
  description = "Enable or disabled the user account"
  type        = bool
  default     = true
}

variable "number_of_users" {
  description = "The number of users to create"
  type        = number
}
