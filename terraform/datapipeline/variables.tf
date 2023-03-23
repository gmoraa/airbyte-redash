variable "region" {
  type = string
  default = "ap-northeast-1"
  description = "AWS region."
}

variable "vpc_cidr" {
  type = string
  description = "VPC cidr"
}