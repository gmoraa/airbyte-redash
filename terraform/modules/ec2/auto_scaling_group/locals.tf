# If the variable 'ami' is empty, then Amazon Linux 2 is selected.
locals {
  ami = var.ami != "" ? var.ami : data.aws_ami.AmazonLinux2.id
}