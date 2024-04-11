provider "aws" {}

resource "random_pet" "run" {
  length = 2
}

module "cloudtrail_s3_bucket" {
  source = "github.com/cloudposse/terraform-aws-cloudtrail"
  # version       = ">=0.15.0"
  name          = random_pet.run.id
  force_destroy = true
}

module "cloudtrail" {
  source = "github.com/cloudposse/terraform-aws-cloudtrail"
  # version                       = ">=0.15.0"
  name                          = random_pet.run.id
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = false
  enable_logging                = true
  s3_bucket_name                = module.cloudtrail_s3_bucket.bucket_id
}

module "observe_lambda" {
  source           = "../.."
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = random_pet.run.id
}

module "observe_lambda_s3_subscription" {
  source      = "../..//modules/s3_bucket_subscription"
  lambda      = module.observe_lambda.lambda_function
  bucket_arns = [module.cloudtrail_s3_bucket.bucket_arn, ]

  # ensure we delete our policy attachments before tearing down policy
  # attachments in the following module, otherwise we hit "conflicting
  # conditional operation" error in AWS API. 
  depends_on = [module.cloudtrail_s3_bucket]
}
