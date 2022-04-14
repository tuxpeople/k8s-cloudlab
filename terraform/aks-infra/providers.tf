terraform {

  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "~>2.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = ">=0.6.3"
    }
  }
}