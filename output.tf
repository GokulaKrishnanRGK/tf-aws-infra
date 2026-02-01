output "vpc_id" {
  value = aws_vpc.csye6225_vpc.id
}

output "public_subnets" {
  value = aws_subnet.dev_public_subnet.*.id
}

output "private_subnets" {
  value = aws_subnet.dev_private_subnet.*.id
}

output "domain_name" {
  value = var.DOMAIN_NAME
}

output "asg_id" {
  value = aws_autoscaling_group.csye6225_asg.id
}

output "aws_route53_zone" {
  value = data.aws_route53_zone.selected_zone.name
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}