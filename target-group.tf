resource "aws_lb_target_group" "csye6225_alb_tg" {
  name        = "csye6225-target-group"
  target_type = var.LB_TARGET_TYPE
  port        = var.APPLICATION_PORT
  protocol    = var.TG_PROTOCOL
  vpc_id      = aws_vpc.csye6225_vpc.id

  health_check {
    path = "/healthz"
    port     = var.APPLICATION_PORT
    matcher  = "200"
    interval = 30
    timeout  = 10
  }

  tags = {
    Name = "csye6225-target-group"
  }
}
