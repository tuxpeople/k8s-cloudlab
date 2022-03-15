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

variable "github_owner" {
  type        = string
  description = "github owner"
  default     = "tuxpeople"
}

variable "repository_name" {
  type        = string
  default     = "k8s-cloudlab"
  description = "github repository name"
}

variable "repository_visibility" {
  type        = string
  default     = "public"
  description = "How visible is the github repo"
}

variable "branch" {
  type        = string
  default     = "master"
  description = "branch name"
}

variable "target_path" {
  type        = string
  default     = "cluster/base"
  description = "flux sync target path"
}