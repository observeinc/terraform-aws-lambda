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
  source           = "../.."
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = random_pet.run.id
}

module "observe_lambda_s3_subscription" {
  source = "../../s3_bucket_subscription"
  lambda = module.observe_lambda.lambda_function
  bucket = aws_s3_bucket.bucket
}
```

Given an S3 bucket and an Observe lambda function, this module notifies the
lambda on object creation events, and grants the necessary permissions for the
lambda function to retrieve the created object.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.21 |
| aws | >= 2.68 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket | S3 bucket to subscribe to Observe Lambda | <pre>object({<br>    arn = string<br>    id  = string<br>  })</pre> | n/a | yes |
| filter\_prefix | Specifies object key name prefix on S3 bucket notifications. | `string` | `""` | no |
| filter\_suffix | Specifies object key name suffix on S3 bucket notifications. | `string` | `""` | no |
| iam\_name\_prefix | Prefix used for all created IAM roles and policies | `string` | `"observe-lambda-"` | no |
| lambda | Observe Lambda module | <pre>object({<br>    arn  = string<br>    role = string<br>  })</pre> | n/a | yes |
| statement\_id\_prefix | Prefix used for Lambda permission statement ID | `string` | `"observe-lambda-"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
