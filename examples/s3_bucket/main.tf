provider "aws" {}

resource "random_pet" "run" {
  length = 2
}

resource "aws_s3_bucket" "bucket" {
  bucket        = random_pet.run.id
  acl           = "private"
  force_destroy = true
}

module "observe_lambda" {
  source           = "../.."
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = random_pet.run.id
}

module "observe_lambda_s3_subscription" {
  source        = "../../s3_bucket_subscription"
  lambda        = module.observe_lambda.lambda_function
  bucket        = aws_s3_bucket.bucket
  filter_prefix = var.filter_prefix
  filter_suffix = var.filter_suffix
}
