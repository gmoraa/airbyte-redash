output "vpc" {
    value = aws_vpc.main_vpc
}

output "subnet" {
    value = aws_subnet.public_subnet
}