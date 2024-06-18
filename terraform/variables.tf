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

variable "application" {
  type        = string
  default     = "hol"
  description = "The application name"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "The Azure region where the resources should be created"
}

variable "tags" {
  type        = map(any)
  description = "The custom tags for all resources"
  default     = {}
}

variable "resource_group_name_suffix" {
  type        = string
  description = "The suffix for the resource group name"
  default     = "01"
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
  type        = string
  default     = "1"
}

variable "number_of_users" {
  description = "The number of users to create"
  type        = number
  default     = 0
}
