locals {
  default_lambda_bucket = format("observeinc-%s", data.aws_region.current.name)
  lambda_iam_role_arn   = var.lambda_iam_role_arn != "" ? var.lambda_iam_role_arn : aws_iam_role.lambda[0].arn
  lambda_iam_role_name  = regex(".*role/(?P<role_name>.*)$", local.lambda_iam_role_arn)["role_name"]
  s3_bucket             = var.s3_bucket != "" ? var.s3_bucket : lookup(var.s3_regional_buckets, data.aws_region.current.name, local.default_lambda_bucket)
  s3_key                = var.s3_key != "" ? var.s3_key : join("/", [var.s3_key_prefix, format("%s.zip", var.lambda_version)])
}

data "aws_region" "current" {}

resource "aws_lambda_function" "this" {
  function_name     = var.name
  s3_bucket         = local.s3_bucket
  s3_key            = local.s3_key
  s3_object_version = var.s3_object_version
  role              = local.lambda_iam_role_arn

  handler     = "main"
  runtime     = "go1.x"
  description = var.description
  kms_key_arn = var.kms_key_arn
  tags        = var.tags

  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  timeout                        = var.timeout

  vpc_config {
    security_group_ids = var.vpc_config == null ? [] : [for s in var.vpc_config.security_groups : s.id]
    subnet_ids         = var.vpc_config == null ? [] : [for s in var.vpc_config.subnets : s.id]
  }

  environment {
    variables = merge({
      OBSERVE_URL   = format("https://collect.%s/v1/observations", var.observe_domain)
      OBSERVE_TOKEN = format("%s %s", var.observe_customer, var.observe_token)
    }, var.lambda_envvars)
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_iam_role_policy_attachment.vpc_access,
  ]
}

resource "aws_iam_role" "lambda" {
  count              = var.lambda_iam_role_arn == "" ? 1 : 0
  name_prefix        = var.iam_name_prefix
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "group" {
  name              = format("/aws/lambda/%s", var.name)
  retention_in_days = var.retention_in_days
}

resource "aws_iam_policy" "lambda_logging" {
  name_prefix = var.iam_name_prefix
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
          "${aws_cloudwatch_log_group.group.arn}*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = local.lambda_iam_role_name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_policy" "vpc_access" {
  count       = var.vpc_config == null ? 0 : 1
  name_prefix = var.iam_name_prefix
  description = "IAM policy for attaching to VPC"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ],
      "Resource": "*",
      "Condition": {
        "ArnLikeIfExists": {
          "ec2:Subnet": ${jsonencode([for s in var.vpc_config.subnets : s.arn])}
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "vpc_access" {
  count      = var.vpc_config == null ? 0 : 1
  role       = local.lambda_iam_role_name
  policy_arn = aws_iam_policy.vpc_access[0].arn
}
