resource "aws_sns_topic" "user_signup_notification" {
  name = "verify_email" #TODO
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Principal = { Service = "lambda.amazonaws.com" },
        Effect    = "Allow"
      }
    ]
  })
}

resource "aws_iam_policy" "sns_publish_policy" {
  name        = "SNSPublishPolicy"
  description = "Policy to allow EC2 instance to publish to SNS topic"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sns:Publish",
        "Resource" : aws_sns_topic.user_signup_notification.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sns_publish_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.sns_publish_policy.arn
}

resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sns:Subscribe",
          "sns:Receive"
        ],
        Resource = aws_sns_topic.user_signup_notification.arn
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_lambda_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_access" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_lambda_function" "send_verification_email" {
  filename      = var.LAMBDA_FILENAME #TODO
  function_name = "email-lambda"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = var.LAMBDA_HANDLER_FN
  runtime       = "java17"

  vpc_config {
    subnet_ids         = [aws_subnet.dev_private_subnet[0].id]
    security_group_ids = [aws_security_group.csye6225_lambda_sg.id]
  }

  environment {
    variables = {
      REGION           = var.REGION
      CSYE6225_SQL_DB_CONNSTR = "jdbc:mysql://${aws_db_instance.csye6225_mysql_instance.address}/${aws_db_instance.csye6225_mysql_instance.db_name}"
      CSYE6225_SQL_DB_USER    = aws_db_instance.csye6225_mysql_instance.username
      CSYE6225_SQL_DB_PWD     = aws_db_instance.csye6225_mysql_instance.password
      MAILGUN_API_KEY         = var.MAILGUN_API_KEY
      SENDER_DOMAIN           = var.SENDER_DOMAIN
    }
  }
  source_code_hash = filebase64sha256(var.LAMBDA_FILENAME)
}

resource "aws_lambda_permission" "allow_sns_invoke" {
  statement_id  = "AllowSNSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.send_verification_email.arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.user_signup_notification.arn
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.user_signup_notification.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.send_verification_email.arn
}