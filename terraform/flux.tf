data "kustomization_build" "flux_system" {
  path = "../cluster/base/flux-system"
}

resource "kustomization_resource" "flux_system" {
  for_each = data.kustomization_build.flux_system.ids

  manifest = data.kustomization_build.flux_system.manifests[each.value]
}

resource "kubernetes_secret" "aks-secrets" {
  metadata {
    name      = "aks-secrets"
    namespace = "flux-system"
  }

  data = {
    loadBalancerIP      = azurerm_public_ip.aks_lb_ingress.ip_address
    resource_group_name = azurerm_public_ip.aks_lb_ingress.resource_group_name
  }
}