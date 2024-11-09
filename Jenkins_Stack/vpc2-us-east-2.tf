
provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

# VPC 2
resource "aws_vpc" "vpc2-us-east2" {
  provider   = aws.us_east_2
  cidr_block = "172.17.0.0/16"
  tags = {
    Name = "vpc2-us-east2"
  }
}

resource "aws_subnet" "pub-subnet-2" {
  vpc_id     = aws_vpc.vpc2-us-east2.id
  provider   = aws.us_east_2
  cidr_block = "172.17.1.0/24"
  tags = {
    Name = "pub-subnet-2"
  }
}
