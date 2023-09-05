# AWS S3 Collection Bucket

This module creates an S3 collection bucket, and is intended as a quick start
for exporting logs out of AWS. The bucket has the appropriate permissions to
be written to from as many AWS services as possible.

## Usage

```hcl
module "observe_s3_bucket"
  source      = "observeinc/lambda/aws//modules/s3_bucket"
  bucket_name = random_pet.run.id
}

module "observe_lambda" {
  source                      = "observeinc/lambda/aws"
  observe_collection_endpoint = var.observe_collection_endpoint
  observe_token               = var.observe_token
  name                        = random_pet.run.id
}

module "observe_lambda_s3_subscription" {
  source      = "observeinc/lambda/aws//modules/s3_bucket_subscription"
  lambda      = module.observe_lambda.lambda_function
  bucket_arns = [aws_s3_bucket.bucket.arn]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 3.7.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_redshift_service_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/redshift_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name | `string` | n/a | yes |
| <a name="input_exported_prefix"></a> [exported\_prefix](#input\_exported\_prefix) | Key prefix which logs are to be written to | `string` | `""` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Destroy all objects when deleting bucket | `bool` | `true` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | List of maps containing configuration of object lifecycle management. | `any` | `[]` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Enable S3 access log collection | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | S3 Bucket ARN |
| <a name="output_id"></a> [id](#output\_id) | S3 Bucket ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
