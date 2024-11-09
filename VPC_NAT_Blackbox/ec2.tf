resource "aws_instance" "ec2_public" {
  provider                    = aws.useast1
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.useast1_public[0].id
  associate_public_ip_address = true
  tags = {
    Name = "EC2Public"
  }
}

resource "aws_instance" "ec2_private" {
  provider      = aws.useast1
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.useast1_private[0].id
  tags = {
    Name = "EC2Private"
  }
}
