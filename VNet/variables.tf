variable "name" {
  type        = string
  default     = "WBotAssig"
}

variable "location" {
  type        = string
  default     = "East US"
}

variable "network_address_space" {
  type        = string
}

variable "aks_subnet_address_name" {
  type        = string
}

variable "aks_subnet_address_prefix" {
  type        = string
}

variable "subnet_address_name" {
  type        = string
}

variable "subnet_address_prefix" {
  type        = string
}