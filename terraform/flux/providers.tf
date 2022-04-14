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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    github = {
      source  = "integrations/github"
      version = ">= 4.5.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}