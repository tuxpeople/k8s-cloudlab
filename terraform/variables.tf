variable "client_id" {}
variable "client_secret" {}

variable "agent_min_count" {
  default = 3
}

variable "agent_max_count" {
  default = 3
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "k8stest"
}

variable "cluster_name" {
  default = "k8stest"
}

variable "resource_group_name" {
  default = "azure-k8stest"
}

variable "location" {
  default = "East US"
}

variable "network_cidrs" {
  default = {
    vnet   = "10.0.0.0/8"
    subnet = "10.1.0.0/16"
  }
  type = object({
    vnet   = string
    subnet = string
  })
}