# declaring provider is required
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# amazon linux
# ami-0ebfd941bbafe70c6
# ubuntu 24 / 64bits / x86
# ami-0866a3c8686eaeeba

resource "aws_instance" "ec2_public" {
  provider                    = aws.us_east_1
  key_name                    = "my-key-pair"
  ami                         = "ami-0866a3c8686eaeeba"
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.pub-subnet-1.id
  security_groups             = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Jenkins-Server"
  }
}

output "ec2_public_ip" {
  value = aws_instance.ec2_public.public_ip
}

# create internet gateway on vpc1
resource "aws_internet_gateway" "gw1" {
  provider = aws.us_east_1
  vpc_id   = aws_vpc.vpc1-us-east1.id
  tags = {
    Name = "gw1"
  }
}

# create route table and define route to internet gateway
resource "aws_route_table" "vpc1_route_table" {
  vpc_id = aws_vpc.vpc1-us-east1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id
  }
}

# Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.pub-subnet-1.id
  route_table_id = aws_route_table.vpc1_route_table.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  provider    = aws.us_east_1
  description = "Allow SSH access"
  vpc_id      = aws_vpc.vpc1-us-east1.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["92.107.114.211/32"]
  }

  # Jenkins
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["92.107.114.211/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

