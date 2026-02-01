resource "aws_route_table" "public_route_table" {
  depends_on = [
    aws_vpc.csye6225_vpc,
  ]

  vpc_id = aws_vpc.csye6225_vpc.id
  tags = {
    Name = "DevPublicRouteTable"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_route_association" {
  count          = 3
  subnet_id      = aws_subnet.dev_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  depends_on = [
    aws_vpc.csye6225_vpc,
  ]

  vpc_id = aws_vpc.csye6225_vpc.id
  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "private_route_association" {
  count          = 3
  subnet_id      = aws_subnet.dev_private_subnet.*.id[count.index]
  route_table_id = aws_route_table.private_route_table.id
}

# TODO
resource "aws_route" "private_default_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
