resource "random_pet" "run" {
  length = 2
}

module "observe_s3_bucket" {
  source      = "../..//modules/s3_bucket"
  count       = var.bucket_count
  bucket_name = format("%s-%d", random_pet.run.id, count.index)
}

module "observe_lambda" {
  source           = "../.."
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = random_pet.run.id
}

module "observe_lambda_s3_subscription" {
  source        = "../..//modules/s3_bucket_subscription"
  lambda        = module.observe_lambda.lambda_function
  bucket_arns   = [for bucket in module.observe_s3_bucket : bucket.arn]
  filter_prefix = var.filter_prefix
  filter_suffix = var.filter_suffix
}

resource "aws_s3_object" "example" {
  depends_on = [module.observe_lambda_s3_subscription]
  count      = length(module.observe_s3_bucket)
  key        = "example.json"
  bucket     = module.observe_s3_bucket[count.index].id
  content    = jsonencode({ hello = "world" })
}
