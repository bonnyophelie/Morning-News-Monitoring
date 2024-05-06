variable "linode_token" {
  type        = string
  description = "Linode Token"
  sensitive   = true
}

variable "linode_image" {
  type        = string
  description = "AMI of the Linode instance deployed"
  sensitive   = true
}
variable "linode_label" {
  type        = string
  description = "Name of the Linode instance deployed"
  sensitive   = true
}
variable "linode_group" {
  type        = string
  description = "Group of the Linode instance deployed"
  sensitive   = true
}

variable "linode_region" {
  type        = string
  description = "Region where the Linode instance is deployed"
  sensitive   = true
}
variable "linode_type" {
  type        = string
  description = "Type of the Linode instance deployed"
  sensitive   = true
}
variable "linode_root_pass" {
  type        = string
  description = "Root password of the Linode instance deployed"
  sensitive   = true
}

variable "linode_authorized_keys" {
  type        = string
  description = "SSH Key used to connect to the instance"
  sensitive   = true
}