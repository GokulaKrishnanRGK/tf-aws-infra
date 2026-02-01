resource "aws_autoscaling_group" "csye6225_asg" {
  launch_template {
    id      = aws_launch_template.csye6225_launch_template.id
    version = "$Latest"
  }
  name             = "csye6225-asg"
  min_size         = var.AGS_MIN_SIZE
  max_size         = var.AGS_MAX_SIZE
  desired_capacity = var.AGS_DESIRED_CAPACITY
  default_cooldown = var.AGS_COOL_DOWN
  vpc_zone_identifier = [for subnet in aws_subnet.dev_public_subnet : subnet.id]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  tag {
    key                 = "Name"
    value               = "csye6225_asg_instance"
    propagate_at_launch = true
  }
  termination_policies = ["OldestInstance", "Default"]
  target_group_arns = [aws_lb_target_group.csye6225_alb_tg.arn]
}
