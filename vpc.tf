resource "aws_vpc" "csye6225_vpc" {
  cidr_block = var.VPC_CIDR

  tags = {
    Name = "dev-vpc"
  }
}
