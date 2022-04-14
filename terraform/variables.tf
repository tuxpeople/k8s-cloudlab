locals {
  infix = "${var.purpose}-${var.environment}"
}

variable "client_id" {}
variable "client_secret" {}
variable "location" {}
variable "ssh_public_key" {}
variable "purpose" {}
variable "environment" {}
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

variable "github_owner" {
  type        = string
  description = "github owner"
}

variable "repository_name" {
  type        = string
  default     = "test-provider"
  description = "github repository name"
}

variable "repository_visibility" {
  type        = string
  default     = "private"
  description = "How visible is the github repo"
}

variable "branch" {
  type        = string
  default     = "main"
  description = "branch name"
}

variable "target_path" {
  type        = string
  default     = "staging-cluster"
  description = "flux sync target path"
}
