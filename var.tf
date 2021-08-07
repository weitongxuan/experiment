variable "resource_group_name" {
  default = "my-test-resource-group"
}

variable "location" {
  default = "Central US"
}

variable "agent_count" {
  default = 3
}

variable "dns_prefix" {
  default = "k8stest"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "cluster_name" {
  default = "k8stest"
}

