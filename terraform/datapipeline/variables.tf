variable "region" {
  type = string
  description = "AWS region."
}

variable "vpc_cidr" {
  type = string
  description = "VPC cidr."
}

variable "airbyte_version" {
  type = string
  default = "0.40.32"
  description = "Airbyte version to deploy."
}