variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Access Key"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "AWS Region where the instance is deployed"
  sensitive   = true
}

variable "aws_key_name" {
  type        = string
  description = "SSH Key used to connect to the instance"
  sensitive   = true
}

variable "aws_public_key" {
  type        = string
  description = "Path of SSH key used to connect to the instance"
  sensitive   = true
}

# variable "aws_allocation_id" {
#  type        = string
#  description = "EIP allocated to the instance deployed"
#  sensitive   = true
#}

variable "aws_ami" {
  type        = string
  description = "AMI of the instance deployed"
  sensitive   = true
}

variable "aws_instance_type" {
  type        = string
  description = "Type of the instance deployed"
  sensitive   = true
}

variable "aws_monitoring_instance_name" {
  type        = string
  description = "Name of the instance deployed"
  sensitive   = true
}

variable "aws_security_group_name" {
  type        = string
  description = "Security Group Name of the instance deployed"
  sensitive   = true
}
