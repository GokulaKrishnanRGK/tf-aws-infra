resource "aws_autoscaling_policy" "asg_scale_up" {
  name                   = "instance_scale_up_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.AGS_COOL_DOWN
  autoscaling_group_name = aws_autoscaling_group.csye6225_asg.name
}

resource "aws_autoscaling_policy" "asg_scale_down" {
  name                   = "instance_scale_down_policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.AGS_COOL_DOWN
  autoscaling_group_name = aws_autoscaling_group.csye6225_asg.name
}

resource "aws_cloudwatch_metric_alarm" "scale_up_cpu_high_alarm" {
  alarm_name          = "Scale_up_alarm_for_high_CPU_Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.SCALE_UP_EVAL
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.SCALE_UP_PERIOD
  statistic           = "Average"
  threshold           = var.SCALE_UP_THRESHOLD
  alarm_description   = "Triggers when average CPU usage is above 15%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.csye6225_asg.name
  }

  alarm_actions = [
    aws_autoscaling_policy.asg_scale_up.arn,
  ]
}

resource "aws_cloudwatch_metric_alarm" "scale_up_cpu_low_alarm" {
  alarm_name          = "Scale_up_alarm_for_low_CPU_Usage"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.SCALE_DOWN_EVAL
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.SCALE_DOWN_PERIOD
  statistic           = "Average"
  threshold           = var.SCALE_DOWN_THRESHOLD
  alarm_description   = "Triggers when average CPU usage is below 8%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.csye6225_asg.name
  }

  alarm_actions = [
    aws_autoscaling_policy.asg_scale_down.arn,
  ]
}
