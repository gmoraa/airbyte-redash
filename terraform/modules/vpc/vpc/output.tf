output "vpc" {
    value = aws_vpc.main_vpc
}

output "subnet_1" {
    value = aws_subnet.public_subnet_1
}

output "subnet_2" {
    value = aws_subnet.public_subnet_2
}