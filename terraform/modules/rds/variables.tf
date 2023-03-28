variable "security_groups" {
    type = list(string)
    default = [""]
    description = "Security groups to be attached to the server."
}

variable "subnet_ids" {
  type          = list(string)
  description   = "Network subnet for the applications."
}