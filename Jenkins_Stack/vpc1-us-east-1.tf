
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

# VPC 1
resource "aws_vpc" "vpc1-us-east1" {
  provider   = aws.us_east_1
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "vpc1-us-east1"
  }
}

resource "aws_subnet" "pub-subnet-1" {
  vpc_id     = aws_vpc.vpc1-us-east1.id
  provider   = aws.us_east_1
  cidr_block = "172.16.1.0/24"
  tags = {
    Name = "pub-subnet-1"
  }
}
