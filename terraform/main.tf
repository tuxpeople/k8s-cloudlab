/* module "infra" {
  source              = "./aks-infra"
  client_id           = var.client_id
  aks                 = var.aks
  location            = var.location
  client_secret       = var.client_secret
  dns_prefix          = var.dns_prefix
  cluster_name        = var.cluster_name
  resource_group_name = var.resource_group_name
  network_cidrs       = var.network_cidrs
  ssh_public_key      = var.ssh_public_key
} */

module "flux" {
  source                = "./flux"
  github_owner          = var.github_owner
  repository_name       = var.repository_name
  repository_visibility = var.repository_visibility
  branch                = var.branch
  target_path           = var.target_path
  loadBalancerIP        = azurerm_public_ip.aks_lb_ingress.ip_address
  resource_group_name   = var.resource_group_name
}