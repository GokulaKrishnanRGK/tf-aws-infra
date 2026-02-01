resource "aws_subnet" "dev_public_subnet" {
  depends_on = [
    aws_vpc.csye6225_vpc,
  ]
  count                   = length(var.PUBLIC_SUBNET_NAMES)
  vpc_id                  = aws_vpc.csye6225_vpc.id
  cidr_block              = cidrsubnet(var.VPC_CIDR, 8, count.index + 10)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.PUBLIC_SUBNET_NAMES[count.index]
  }
}

resource "aws_subnet" "dev_private_subnet" {
  depends_on = [
    aws_vpc.csye6225_vpc,
  ]
  count                   = length(var.PRIVATE_SUBNET_NAMES)
  vpc_id                  = aws_vpc.csye6225_vpc.id
  cidr_block              = cidrsubnet(var.VPC_CIDR, 8, count.index + 20)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = var.PRIVATE_SUBNET_NAMES[count.index]
  }
}
