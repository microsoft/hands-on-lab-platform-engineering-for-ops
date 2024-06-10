terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.51.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.107.0"
    }
  }

  backend "local" {}
  # backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
