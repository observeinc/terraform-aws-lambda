# AWS S3 Bucket Subscription to Observe Lambda

Given an S3 bucket and an Observe lambda function, this module notifies the
lambda on object creation events, and grants the necessary permissions for the
lambda function to retrieve the newly created object.

## Terraform versions

Terraform 0.12 and newer. Submit pull-requests to `main` branch.

## Usage

```hcl
resource "aws_s3_bucket" "bucket" {
  bucket        = random_pet.run.id
  acl           = "private"
  force_destroy = true
}

module "observe_lambda" {
  source           = "github.com/observeinc/terraform-aws-lambda"
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = random_pet.run.id
}

module "observe_lambda_s3_subscription" {
  source      = "github.com/observeinc/terraform-aws-lambda//modules/s3_bucket_subscription"
  lambda      = module.observe_lambda.lambda_function
  bucket_arns = [aws_s3_bucket.bucket.arn]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.68 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.68 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.s3_bucket_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.lambda_s3_bucket_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_permission.allow_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_notification.notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_arns"></a> [bucket\_arns](#input\_bucket\_arns) | S3 bucket ARNs to subscribe to Observe Lambda | `list(string)` | `[]` | no |
| <a name="input_filter_prefix"></a> [filter\_prefix](#input\_filter\_prefix) | Specifies object key name prefix on S3 bucket notifications. | `string` | `""` | no |
| <a name="input_filter_suffix"></a> [filter\_suffix](#input\_filter\_suffix) | Specifies object key name suffix on S3 bucket notifications. | `string` | `""` | no |
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | Prefix used for all created IAM roles and policies | `string` | `"observe-lambda-"` | no |
| <a name="input_lambda"></a> [lambda](#input\_lambda) | Observe Lambda module | <pre>object({<br>    arn  = string<br>    role = string<br>  })</pre> | n/a | yes |
| <a name="input_statement_id_prefix"></a> [statement\_id\_prefix](#input\_statement\_id\_prefix) | Prefix used for Lambda permission statement ID | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
