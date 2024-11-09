
# Create internet gateway for vpc1
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id
}

# Associate internet gateway with VPC route table
resource "aws_route" "route_to_internet" {
  route_table_id            = aws_route_table.vpc1_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
}
