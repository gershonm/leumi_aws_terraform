variable "aws_key" {
  type = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR range of the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  type    = string
}

variable "EC2_name" {
  type    = string
}

variable "leumi_proxy" {
  type = string
}

variable "instance_type" {
  type = string
}