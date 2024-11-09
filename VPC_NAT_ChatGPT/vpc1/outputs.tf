output "vpc1_id" {
  value = aws_vpc.vpc1.id
}

output "vpc1_public_subnets" {
  value = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
}

output "vpc1_private_subnets" {
  value = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}

output "vpc1_internet_gateway" {
  value = aws_internet_gateway.gw1.id
}

output "vpc1_nat_gateway" {
  value = aws_nat_gateway.nat1.id
}

output "bastion_host" {
  value = aws_instance.bastion.id
}

output "ec2_public" {
  value = aws_instance.ec2_public.id
}

output "ec2_private" {
  value = aws_instance.ec2_private.id
}
 
