variable "name" {
  type    = string
  default = "WBotAssig"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "addons" {
  type = object({
    oms_agent                   = bool
    ingress_application_gateway = bool
  })
}

variable "kubernetes_cluster_rbac_enabled" {
  default = "true"
}

variable "kubernetes_version" {
}

variable "agent_count" {
}

variable "vm_size" {
}

variable "ssh_public_key" {
}

variable "aks_admins_group_object_id" {
}