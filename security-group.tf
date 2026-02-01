resource "aws_security_group" "csye6225_lb_security_group" {
  name        = "load_balancer_security_group"
  description = "Security group for the Load Balancer"
  vpc_id      = aws_vpc.csye6225_vpc.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "load_balancer_security_group"
  }
}

resource "aws_security_group" "csye6225_security_group" {
  name        = "application-security-group"
  description = "Allow SSH, HTTP, HTTPS, and application port traffic"
  vpc_id      = aws_vpc.csye6225_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # security_groups = [aws_security_group.csye6225_lb_security_group.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP traffic from anywhere
  # ingress {
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # # Allow HTTPS traffic from anywhere
  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    from_port = var.APPLICATION_PORT
    to_port   = var.APPLICATION_PORT
    protocol  = "tcp"
    security_groups = [aws_security_group.csye6225_lb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "application-security-group"
  }
}

resource "aws_security_group" "csye6225_rds_security_group" {
  name        = "database-security-group"
  description = "Allow access to RDS instance"
  vpc_id      = aws_vpc.csye6225_vpc.id

  ingress {
    from_port       = var.DB_PORT
    to_port         = var.DB_PORT
    protocol        = "tcp"
    security_groups = [aws_security_group.csye6225_security_group.id] # Allow only EC2 instances to connect
  }

  ingress {
    from_port       = var.DB_PORT
    to_port         = var.DB_PORT
    protocol        = "tcp"
    security_groups = [aws_security_group.csye6225_lambda_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-security-group"
  }
}


data "aws_acm_certificate" "issued" {
  domain   = var.DOMAIN_NAME
  statuses = ["ISSUED"]
}

resource "aws_lb_listener" "csye6225_app_listener" {
  load_balancer_arn = aws_lb.csye6225_alb.arn
  port            = "443"
  protocol        = "HTTPS"
  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.csye6225_alb_tg.arn
  }
}

resource "aws_security_group" "csye6225_lambda_sg" {
  name        = "lambda-security-group"
  description = "Allow Lambda to reach RDS"
  vpc_id      = aws_vpc.csye6225_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lambda-security-group"
  }
}
