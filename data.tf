data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}


locals {
  az_count = min(3, length(data.aws_availability_zones.available.names))
}