provider "aws" {}

resource "aws_s3_bucket" "monitored" {
  bucket        = format("%s-access-logs", var.name)
  force_destroy = true
}

resource "aws_s3_bucket_acl" "monitored" {
  bucket = aws_s3_bucket.monitored.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "access_logs" {
  bucket = var.name

  logging {
    target_bucket = aws_s3_bucket.monitored.id
    target_prefix = "log/"
  }

  force_destroy = true
}

resource "aws_s3_bucket_acl" "access_logs" {
  bucket = aws_s3_bucket.access_logs.id
  acl    = "private"
}

module "observe_lambda" {
  source           = "../.."
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = var.name
}

module "observe_lambda_s3_subscription" {
  source      = "../..//modules/s3_bucket_subscription"
  lambda      = module.observe_lambda.lambda_function
  bucket_arns = [aws_s3_bucket.access_logs.arn, ]
}
