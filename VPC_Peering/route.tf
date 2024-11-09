
# Define route tables
resource "aws_route_table" "vpc1_route_table" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table" "vpc2_route_table" {
  vpc_id = aws_vpc.vpc2.id
}

# Create route in route tables for VPC peering
resource "aws_route" "route1" {
  route_table_id            = aws_route_table.vpc1_route_table.id
  destination_cidr_block    = aws_vpc.vpc2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

resource "aws_route" "route2" {
  route_table_id            = aws_route_table.vpc2_route_table.id
  destination_cidr_block    = aws_vpc.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}
