variable "REGION" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "PROFILE" {
  type    = string
}

variable "VPC_CIDR" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.20.0.0/16"
}

variable "PUBLIC_SUBNET_NAMES" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["PublicSubnet1", "PublicSubnet2", "PublicSubnet3"]
}

variable "PRIVATE_SUBNET_NAMES" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["PrivateSubnet1", "PrivateSubnet2", "PrivateSubnet3"]
}

variable "APPLICATION_PORT" {
  type        = number
  description = "Port on which the application runs"
  default     = "8080"
}

variable "SPRING_ACTIVE_PROFILES" {
  type        = string
  description = "spring profile"
  default     = "aws"
}

variable "AMI_ID" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "INSTANCE_TYPE" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t3.micro"
}

variable "DB_NAME" {
  type        = string
  description = "Name of the RDS database"
  default     = "csye6225"
}

variable "DB_USERNAME" {
  type        = string
  description = "Username for the RDS database"
  default     = "csye6225"
}

variable "DB_PORT" {
  type        = number
  description = "DB Port for Postgres database"
  default     = 3306
}

variable "DB_IDENTIFIER" {
  type        = string
  description = "Identifier for the RDS database"
  default     = "csye6225"
}

variable "DOMAIN_NAME" {
  description = "The domain name for the Route 53 hosted zone."
  type        = string
}

# ssh_key_name
variable "SSH_KEY_NAME" {
  type        = string
  description = "SSH key Name for launch templates"
  default     = "ec2"
}

# auto scaling group
variable "AGS_MIN_SIZE" {
  description = "Auto scaling group min size"
  type        = number
  default     = 1
}

variable "AGS_MAX_SIZE" {
  description = "Auto scaling group max size"
  type        = number
  default     = 3
}

variable "AGS_DESIRED_CAPACITY" {
  description = "Auto scaling group desired capacity"
  type        = number
  default     = 1
}

variable "AGS_COOL_DOWN" {
  description = "Auto scaling group cool down"
  type        = number
  default     = 60
}

variable "SCALE_UP_EVAL" {
  description = "evaluation period for scale up "
  type        = number
  default     = 1
}

variable "SCALE_UP_PERIOD" {
  description = "scale up period"
  type        = number
  default     = 60
}

variable "SCALE_UP_THRESHOLD" {
  description = "threshold for scale up policy"
  type        = number
  default     = 10
}

variable "SCALE_DOWN_EVAL" {
  description = "evaluation period for scale down "
  type        = number
  default     = 1
}

variable "SCALE_DOWN_PERIOD" {
  description = "scale down period"
  type        = number
  default     = 60
}

variable "SCALE_DOWN_THRESHOLD" {
  description = "threshold for scale down policy"
  type        = number
  default     = 5
}

variable "LB_TYPE" {
  description = "Type of ALB"
  type        = string
  default     = "application"
}


variable "LB_TARGET_TYPE" {
  description = "load balancer target type"
  type        = string
  default     = "instance"
}

variable "TG_PROTOCOL" {
  description = "target group protocol"
  type        = string
  default     = "HTTP"
}

variable "LAMBDA_FILENAME" {
  description = "lambda artifacts path"
  type        = string
}

variable "MAILGUN_API_KEY" {
  type        = string
  description = "Mailgun api key"
}

variable "SENDER_DOMAIN" {
  type        = string
  description = "Sender domain"
}

variable "BASE_URL" {
  description = "Application base url"
  type        = string
}

variable "FROM_EMAIL" {
  description = "from email to send email through sendgrid"
  type        = string
}

variable "USER_ACCOUNT_ID" {
  description = "Demo / Dev account id"
  type        = string
}

variable "LAMBDA_HANDLER_FN" {
  description = "Lambda handler function"
  type        = string
}
