resource "aws_launch_template" "csye6225_launch_template" {
  name          = "csye6225-launch-template"
  image_id      = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name      = var.SSH_KEY_NAME
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      aws_security_group.csye6225_security_group.id,
    ]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }
  disable_api_termination = false
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 25
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = aws_kms_key.ec2_kms_key.arn
    }
  }
  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    APPLICATION_PORT       = var.APPLICATION_PORT
    IP_ADDRESS             = aws_db_instance.csye6225_mysql_instance.address
    USERNAME               = aws_db_instance.csye6225_mysql_instance.username
    PASSWORD               = aws_db_instance.csye6225_mysql_instance.password
    DB_NAME                = aws_db_instance.csye6225_mysql_instance.db_name
    SPRING_ACTIVE_PROFILES = var.SPRING_ACTIVE_PROFILES
  }))
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-server-instance"
    }
  }
}
