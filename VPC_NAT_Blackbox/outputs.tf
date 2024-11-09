output "vpc_ids" {
  value = {
    useast1 = aws_vpc.useast1.id
    useast2 = aws_vpc.useast2.id
  }
}

output "public_subnet_ids" {
  value = {
    useast1 = aws_subnet.useast1_public.*.id
    useast2 = aws_subnet.useast2_public.*.id
  }
}

output "private_subnet_ids" {
  value = {
    useast1 = aws_subnet.useast1_private.*.id
    useast2 = aws_subnet.useast2_private.*.id
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "ec2_public_ip" {
  value = aws_instance.ec2_public.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.ec2_private.private_ip
}
