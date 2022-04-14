variable "client_id" {}
variable "client_secret" {}
variable "location" {}
variable "ssh_public_key" {}
variable "dns_prefix" {}
variable "cluster_name" {}
variable "resource_group_name" {}
variable "network_cidrs" {
  type = object({
    vnet   = string
    subnet = string
  })
}
variable "aks" {
  type = object({
    // az aks get-versions --location westeurope -o table
    kubernetes_version    = string
    availability_zones    = list(number)
    log_retention_in_days = number
    node_pool = object({
      agent_min_count = string
      agent_max_count = string
      vm_size         = string
    })
  })
}
