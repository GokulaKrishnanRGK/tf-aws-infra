resource "aws_internet_gateway" "igw" {
  depends_on = [
    aws_vpc.csye6225_vpc,
  ]
  vpc_id = aws_vpc.csye6225_vpc.id
  tags = {
    Name = "dev-IGW"
  }
}

# TODO
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.dev_public_subnet[0].id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "dev-nat-gateway"
  }
}
