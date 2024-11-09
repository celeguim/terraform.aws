
provider "aws" {
  alias  = "vpc2"
  region = "us-east-2"
}

resource "aws_vpc" "vpc2" {
  provider   = aws.vpc2
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc2"
  }
}

resource "aws_internet_gateway" "gw2" {
  provider = aws.vpc2
  vpc_id   = aws_vpc.vpc2.id

  tags = {
    Name = "gw2"
  }
}

resource "aws_nat_gateway" "nat2" {
  provider      = aws.vpc2
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "nat2"
  }
}

resource "aws_eip" "nat2" {
  provider = aws.vpc2
}

resource "aws_subnet" "public_subnet1" {
  provider                = aws.vpc2
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = element(var.public_subnet_cidrs, 0)
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  provider                = aws.vpc2
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = element(var.public_subnet_cidrs, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_subnet" "private_subnet1" {
  provider   = aws.vpc2
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = element(var.private_subnet_cidrs, 0)

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  provider   = aws.vpc2
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = element(var.private_subnet_cidrs, 1)

  tags = {
    Name = "private_subnet2"
  }
}

resource "aws_instance" "bastion" {
  provider                    = aws.vpc2
  ami                         = "ami-0c55b159cbfafe1f0" # Update with a valid AMI for us-east-2
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet1.id
  associate_public_ip_address = true

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "ec2_public" {
  provider                    = aws.vpc2
  ami                         = "ami-0c55b159cbfafe1f0" # Update with a valid AMI for us-east-2
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet2.id
  associate_public_ip_address = true

  tags = {
    Name = "ec2-public"
  }
}

resource "aws_instance" "ec2_private" {
  provider      = aws.vpc2
  ami           = "ami-0c55b159cbfafe1f0" # Update with a valid AMI for us-east-2
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet1.id

  tags = {
    Name = "ec2-private"
  }
}
