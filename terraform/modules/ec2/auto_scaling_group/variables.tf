variable "application" {
    type = string
    description = "Purpose of the auto scaling group, application to be used."
}

variable "ami" {
  type          = string
  default       = ""
  description   = "Amazon Machine Image, operating system for the server."
}

variable "subnet_id" {
  type          = string
  description   = "Network subnet for the applications."
}

variable "instance_type" {
  type          = string
  default       = "t2.large"
  description   = "Instace types, combination of CPU, memory, storage and network capacity."
}

variable "root_size" {
  type          = string
  default       = "100"
  description   = "Root disk space size."
}

variable "user_data" {
    type = string
    description = "Initialization bash script for the server."
}

variable "security_groups" {
    type = list(string)
    default = [""]
    description = "Security groups to be attached to the server."
}