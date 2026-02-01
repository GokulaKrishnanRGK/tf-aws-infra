# resource "aws_kms_key" "ec2_kms_key" {
#   description              = "KMS Key for encrypting EC2 EBS volumes"
#   deletion_window_in_days  = 10
#   enable_key_rotation      = true
#   customer_master_key_spec = "SYMMETRIC_DEFAULT"
#
#   tags = {
#     Name = "EC2 KMS Key - ${timestamp()}"
#   }
#
#   policy = <<EOF
# {
#   "Id": "key-for-ec2",
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "Enable IAM User Permissions",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#       },
#       "Action": "kms:*",
#       "Resource": "*"
#     },
#     {
#           "Sid" : "Allow access for Key Administrators",
#           "Effect" : "Allow",
#           "Principal" : {
#             "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
#           },
#           "Action" : [
#             "kms:Create*",
#             "kms:Describe*",
#             "kms:Enable*",
#             "kms:List*",
#             "kms:Put*",
#             "kms:Update*",
#             "kms:Revoke*",
#             "kms:Disable*",
#             "kms:Get*",
#             "kms:Delete*",
#             "kms:TagResource",
#             "kms:UntagResource",
#             "kms:ScheduleKeyDeletion",
#             "kms:CancelKeyDeletion"
#           ],
#           "Resource" : "*"
#     }
#     ,
#     {
#       "Sid": "Allow EC2 Use of the Key",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
#       },
#       "Action": [
#         "kms:Encrypt",
#         "kms:Decrypt",
#         "kms:ReEncrypt*",
#         "kms:GenerateDataKey*",
#         "kms:DescribeKey"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Sid": "Allow Attachment of Persistent Resources",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
#       },
#       "Action": [
#         "kms:CreateGrant",
#         "kms:ListGrants",
#         "kms:RevokeGrant"
#       ],
#       "Resource": "*",
#       "Condition": {
#         "Bool": {
#           "kms:GrantIsForAWSResource": "true"
#         }
#       }
#     }
#   ]
# }
# EOF
# }
#
# resource "aws_kms_alias" "alias_key_ec2" {
#   name          = "alias/ec2-key"
#   target_key_id = aws_kms_key.ec2_kms_key.key_id
# }
#
#
# resource "aws_kms_key" "rds_kms_key" {
#   description              = "KMS Key for encrypting RDS databases"
#   deletion_window_in_days  = 10
#   enable_key_rotation      = true
#   customer_master_key_spec = "SYMMETRIC_DEFAULT"
#
#   tags = {
#     Name = "RDS KMS Key - ${timestamp()}"
#   }
#
#   policy = <<EOF
# {
#   "Id": "key-for-rds",
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "Enable IAM User Permissions",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#       },
#       "Action": "kms:*",
#       "Resource": "*"
#     },
#     {
#           "Sid" : "Allow access for Key Administrators",
#           "Effect" : "Allow",
#           "Principal" : {
#             "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"
#           },
#           "Action" : [
#             "kms:Create*",
#             "kms:Describe*",
#             "kms:Enable*",
#             "kms:List*",
#             "kms:Put*",
#             "kms:Update*",
#             "kms:Revoke*",
#             "kms:Disable*",
#             "kms:Get*",
#             "kms:Delete*",
#             "kms:TagResource",
#             "kms:UntagResource",
#             "kms:ScheduleKeyDeletion",
#             "kms:CancelKeyDeletion"
#           ],
#           "Resource" : "*"
#     }
#     ,
#     {
#       "Sid": "Allow RDS Use of the Key",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"
#       },
#       "Action": [
#         "kms:Encrypt",
#         "kms:Decrypt",
#         "kms:ReEncrypt*",
#         "kms:GenerateDataKey*",
#         "kms:DescribeKey"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Sid": "Allow RDS Use of the Key",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/IAMRoleForEc2"
#       },
#       "Action": [
#         "kms:Encrypt",
#         "kms:Decrypt",
#         "kms:ReEncrypt*",
#         "kms:GenerateDataKey*",
#         "kms:DescribeKey"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Sid": "Allow Attachment of Persistent Resources",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"
#       },
#       "Action": [
#         "kms:CreateGrant",
#         "kms:ListGrants",
#         "kms:RevokeGrant"
#       ],
#       "Resource": "*",
#       "Condition": {
#         "Bool": {
#           "kms:GrantIsForAWSResource": "true"
#         }
#       }
#     }
#   ]
# }
# EOF
# }
#
# resource "aws_kms_alias" "alias_key_rds" {
#   name          = "alias/rds-key"
#   target_key_id = aws_kms_key.rds_kms_key.key_id
# }
#
# #TODO - line 253
# resource "aws_kms_key" "secrets_kms_key" {
#   description              = "KMS Key for encrypting Secrets Manager secrets"
#   deletion_window_in_days  = 10
#   enable_key_rotation      = true
#   customer_master_key_spec = "SYMMETRIC_DEFAULT"
#
#   tags = {
#     Name = "Secrets Manager KMS Key - ${timestamp()}"
#   }
#
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Id": "secrets-kms-policy",
#   "Statement": [
#     {
#       "Sid": "AllowSecretsManagerUse",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "secretsmanager.amazonaws.com"
#       },
#       "Action": [
#         "kms:Encrypt",
#         "kms:Decrypt",
#         "kms:DescribeKey",
#         "kms:ReEncrypt*",
#         "kms:GenerateDataKey*"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Sid": "EnableRootAccess",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#       },
#       "Action": "kms:*",
#       "Resource": "*"
#     },
#     {
#       "Sid": "AllowEC2RoleDecryptAccess",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/IAMRoleForEc2"
#       },
#       "Action": "kms:Decrypt",
#       "Resource": "*"
#     },
#     {
#       "Sid": "AllowKeyAdminAccess",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/dev"
#       },
#       "Action": [
#         "kms:Create*",
#         "kms:Describe*",
#         "kms:Enable*",
#         "kms:List*",
#         "kms:Put*",
#         "kms:Update*",
#         "kms:Revoke*",
#         "kms:Disable*",
#         "kms:Get*",
#         "kms:Delete*",
#         "kms:TagResource",
#         "kms:UntagResource",
#         "kms:ScheduleKeyDeletion",
#         "kms:CancelKeyDeletion",
#         "kms:RotateKeyOnDemand",
#         "secretsmanager:GetSecretValue"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }
#
#

resource "aws_kms_key" "ec2_kms_key" {
  description              = "KMS Key for encrypting EC2 EBS volumes"
  deletion_window_in_days  = 10
  enable_key_rotation      = true
  customer_master_key_spec = "SYMMETRIC_DEFAULT"

  tags = {
    Name = "EC2 KMS Key - ${timestamp()}"
  }

  policy = <<EOF
{
  "Id": "key-for-ec2",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        "Resource" : "*"
    }
    ,
    {
      "Sid": "Allow EC2 Use of the Key",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow Attachment of Persistent Resources",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ],
      "Resource": "*",
      "Condition": {
        "Bool": {
          "kms:GrantIsForAWSResource": "true"
        }
      }
    }
  ]
}
EOF
}

resource "aws_kms_alias" "alias_key_ec2" {
  name          = "alias/ec2-key"
  target_key_id = aws_kms_key.ec2_kms_key.key_id
}


resource "aws_kms_key" "rds_kms_key" {
  description              = "KMS Key for encrypting RDS databases"
  deletion_window_in_days  = 10
  enable_key_rotation      = true
  customer_master_key_spec = "SYMMETRIC_DEFAULT"

  tags = {
    Name = "RDS KMS Key - ${timestamp()}"
  }

  policy = <<EOF
{
  "Id": "key-for-rds",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
          "Sid" : "Allow access for Key Administrators",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Create*",
            "kms:Describe*",
            "kms:Enable*",
            "kms:List*",
            "kms:Put*",
            "kms:Update*",
            "kms:Revoke*",
            "kms:Disable*",
            "kms:Get*",
            "kms:Delete*",
            "kms:TagResource",
            "kms:UntagResource",
            "kms:ScheduleKeyDeletion",
            "kms:CancelKeyDeletion"
          ],
          "Resource" : "*"
    }
    ,
    {
      "Sid": "Allow RDS Use of the Key",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow RDS Use of the Key",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow Attachment of Persistent Resources",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ],
      "Resource": "*",
      "Condition": {
        "Bool": {
          "kms:GrantIsForAWSResource": "true"
        }
      }
    }
  ]
}
EOF
}

resource "aws_kms_alias" "alias_key_rds" {
  name          = "alias/rds-key"
  target_key_id = aws_kms_key.rds_kms_key.key_id
}

#TODO - line 253
resource "aws_kms_key" "secrets_kms_key" {
  description              = "KMS Key for encrypting Secrets Manager secrets"
  deletion_window_in_days  = 10
  enable_key_rotation      = true
  customer_master_key_spec = "SYMMETRIC_DEFAULT"

  tags = {
    Name = "Secrets Manager KMS Key - ${timestamp()}"
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "secrets-kms-policy",
  "Statement": [
    {
      "Sid": "AllowSecretsManagerUse",
      "Effect": "Allow",
      "Principal": {
        "Service": "secretsmanager.amazonaws.com"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*"
      ],
      "Resource": "*"
    },
    {
      "Sid": "EnableRootAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "AllowEC2RoleDecryptAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "kms:Decrypt",
      "Resource": "*"
    },
    {
      "Sid": "AllowKeyAdminAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion",
        "kms:RotateKeyOnDemand",
        "secretsmanager:GetSecretValue"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
