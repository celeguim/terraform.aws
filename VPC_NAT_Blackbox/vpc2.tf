resource "aws_vpc" "useast2" {
  provider   = aws.useast2
  cidr_block = var.vpc_cidr["useast2"]
}

resource "aws_subnet" "useast2_public" {
  provider                = aws.useast2
  count                   = 2
  vpc_id                  = aws_vpc.useast2.id
  cidr_block              = element(var.public_subnet_cidrs["useast2"], count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "useast2_private" {
  provider   = aws.useast2
  count      = 2
  vpc_id     = aws_vpc.useast2.id
  cidr_block = element(var.private_subnet_cidrs["useast2"], count.index)
}
