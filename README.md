# AWS Lambda Terraform module

Terraform module which sets up a Lambda to forward event data towards Observe.

## Terraform versions

Terraform 0.12 and newer. Submit pull-requests to `main` branch.

## Usage

```hcl
module "observe_lambda" {
  source = "github.com/observeinc/terraform-aws-lambda"

  name                = "observe-lambda"
  observe_customer    = "<id>"
  observe_token       = "<token>"
}
```

This module will create a Lambda. If no role ARN is provided, a new role will be created.

Additionally, this repository provides submodules to interact with the lambda function set up by this module:

* [Upload S3 objects using S3 bucket notifications](https://github.com/observeinc/terraform-aws-lambda/tree/main/s3_bucket_subscription)

## Examples

This repository contains examples of how to solve for concrete usecases:

* [S3 archive to Lambda](https://github.com/observeinc/terraform-aws-lambda/tree/main/examples/s3_bucket)
* [Cloudtrail to Lambda via S3](https://github.com/observeinc/terraform-aws-lambda/tree/main/examples/cloudtrail)

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
| description | Lambda description | `string` | `"Lambda function to forward events towards Observe"` | no |
| iam\_name\_prefix | Prefix used for all created IAM roles and policies | `string` | `"observe-lambda-"` | no |
| kms\_key\_arn | The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your function's environment variables.<br>If it's not provided, AWS Lambda uses a default service key. | `string` | `""` | no |
| lambda\_envvars | Environment variables | `map(any)` | `{}` | no |
| lambda\_iam\_role\_arn | ARN of IAM role to use for Lambda | `string` | `""` | no |
| lambda\_version | Version of lambda binary to use | `string` | `"latest"` | no |
| memory\_size | The amount of memory that your function has access to. Increasing the function's memory also increases its CPU allocation.<br>The default value is 128 MB. The value must be a multiple of 64 MB. | `number` | `128` | no |
| name | Name of Lambda resource | `string` | n/a | yes |
| observe\_customer | Observe Customer ID | `string` | n/a | yes |
| observe\_domain | Observe domain | `string` | `"observeinc.com"` | no |
| observe\_token | Observe Token | `string` | n/a | yes |
| reserved\_concurrent\_executions | The number of simultaneous executions to reserve for the function. | `number` | `100` | no |
| retention\_in\_days | Retention in days of cloudwatch log group | `number` | `14` | no |
| s3\_bucket | S3 Bucket hosting lambda binary. If provided, overrides regional bucket map | `string` | `""` | no |
| s3\_key | S3 object key for lambda binary. If provided, overrides s3\_key\_prefix | `string` | `""` | no |
| s3\_key\_prefix | S3 key containing lambda binaries | `string` | `"lambda/observer"` | no |
| s3\_object\_version | S3 object version for lambda binary | `string` | `""` | no |
| s3\_regional\_buckets | Map of AWS regions to lambda hosting S3 buckets | `map(any)` | `{}` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| timeout | The amount of time that Lambda allows a function to run before stopping it.<br>The maximum allowed value is 900 seconds. | `number` | `60` | no |
| vpc\_config | VPC Config | <pre>object({<br>    security_groups = list(object({<br>      id = string<br>    }))<br>    subnets = list(object({<br>      arn = string<br>      id  = string<br>    }))<br>  })</pre> | `null` | no |
| dead\_letter_\queue\_destination|Send failed events/function executions to a dead letter queue arn sns or sqs| `string` | null | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_function | Observe Lambda function |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
