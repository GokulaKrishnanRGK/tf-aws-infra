resource "random_password" "db_password" {
  length  = 16
  special = false
}

resource "aws_db_parameter_group" "csye6225_mysql_parameter_group" {
  name        = "csye6225-mysql-parameter-group"
  family      = "mysql8.0"
  description = "Parameter group for CSYE6225 MySQL RDS instance"
  parameter {
    name  = "require_secure_transport"
    value = "OFF"
  }
}

resource "aws_db_instance" "csye6225_mysql_instance" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t4g.micro"
  identifier              = var.DB_IDENTIFIER
  username                = var.DB_USERNAME
  password                = random_password.db_password.result
  db_name                 = var.DB_NAME
  port                    = var.DB_PORT
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7
  multi_az                = false
  parameter_group_name    = aws_db_parameter_group.csye6225_mysql_parameter_group.name

  vpc_security_group_ids = [aws_security_group.csye6225_rds_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.csye6225_rds_subnet_group.name

  storage_encrypted = true
  kms_key_id        = aws_kms_key.rds_kms_key.arn

  tags = {
    Name = "csye6225-mysql-db"
  }
}

resource "aws_db_subnet_group" "csye6225_rds_subnet_group" {
  name       = "csye6225-rds-subnet-group"
  subnet_ids = aws_subnet.dev_private_subnet.*.id

  tags = {
    Name = "csye6225-rds-subnet-group"
  }
}
