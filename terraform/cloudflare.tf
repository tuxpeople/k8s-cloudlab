
data "cloudflare_zones" "domain" {
  filter {
    name = data.sops_file.sops_secrets.data["cloudflare_domain"]
  }
}

resource "cloudflare_record" "api" {
  name    = "${local.infix}-api"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = azurerm_kubernetes_cluster.k8s.fqdn
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "ingress" {
  name    = "${local.infix}-ingress"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = azurerm_public_ip.aks_lb_ingress.ip_address
  proxied = true
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "test" {
  name    = "${local.infix}-test"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = azurerm_public_ip.aks_lb_ingress.ip_address
  proxied = true
  type    = "A"
  ttl     = 1
}
