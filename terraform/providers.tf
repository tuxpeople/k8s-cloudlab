terraform {

  required_version = "~> 1.0"

  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "~>3.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = ">=0.6.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=3.10.0"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "0.9.6"
    }
  }
}

data "sops_file" "sops_secrets" {
  source_file = "config/secret.sops.yaml"
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  features {}
}

provider "cloudflare" {
  email   = data.sops_file.sops_secrets.data["cloudflare_email"]
  api_key = data.sops_file.sops_secrets.data["cloudflare_apikey"]
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
}

provider "kustomization" {
  kubeconfig_raw = azurerm_kubernetes_cluster.k8s.kube_config_raw
}