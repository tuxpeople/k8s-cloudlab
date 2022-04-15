# Flux
data "kustomization_build" "flux_system" {
  path = "../${var.target_path}/flux-system"
}

resource "kustomization_resource" "flux_system" {
  for_each = data.kustomization_build.flux_system.ids
  manifest = data.kustomization_build.flux_system.manifests[each.value]
}

resource "kubernetes_secret" "aks-secrets" {
  metadata {
    name      = "aks-secrets"
    namespace = "kube-system"
  }

  data = {
    loadBalancerIP      = azurerm_public_ip.aks_lb_ingress.ip_address
    resource_group_name = azurerm_resource_group.k8s.location
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}