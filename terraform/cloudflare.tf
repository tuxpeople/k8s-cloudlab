
data "cloudflare_zones" "domain" {
  filter {
    name = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  }
}

resource "cloudflare_record" "ipv4" {
  name    = "azure"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = azurerm_kubernetes_cluster.k8s.fqdn
  proxied = true
  type    = "CNAME"
  ttl     = 1
}
