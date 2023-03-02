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
* [Subscribe CloudWatch Logs to Observe Lambda](https://github.com/observeinc/terraform-aws-lambda/tree/main/cloudwatch_logs_subscription)
* [Collect API snapshots](https://github.com/observeinc/terraform-aws-lambda/tree/main/snapshot)

## Examples

This repository contains examples of how to solve for concrete usecases:

* [S3 archive to Lambda](https://github.com/observeinc/terraform-aws-lambda/tree/main/examples/s3_bucket)
* [Cloudtrail to Lambda via S3](https://github.com/observeinc/terraform-aws-lambda/tree/main/examples/cloudtrail)
* [Configuring Lambda in private VPC](https://github.com/observeinc/terraform-aws-lambda/tree/main/examples/vpc_config)
* [Collecting S3 Access Logs](https://github.com/observeinc/terraform-aws-lambda/tree/main/examples/s3_access_logs)

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
| [aws_cloudwatch_log_group.group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.vpc_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vpc_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dead_letter_queue_destination"></a> [dead\_letter\_queue\_destination](#input\_dead\_letter\_queue\_destination) | Send failed events/function executions to a dead letter queue arn sns or sqs | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Lambda description | `string` | `"Lambda function to forward events towards Observe"` | no |
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | Prefix used for all created IAM roles and policies | `string` | `"observe-lambda-"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your function's environment variables.<br>If it's not provided, AWS Lambda uses a default service key. | `string` | `""` | no |
| <a name="input_lambda_envvars"></a> [lambda\_envvars](#input\_lambda\_envvars) | Environment variables | `map(any)` | `{}` | no |
| <a name="input_lambda_iam_role_arn"></a> [lambda\_iam\_role\_arn](#input\_lambda\_iam\_role\_arn) | ARN of IAM role to use for Lambda | `string` | `""` | no |
| <a name="input_lambda_s3_custom_rules"></a> [lambda\_s3\_custom\_rules](#input\_lambda\_s3\_custom\_rules) | List of rules to evaluate how to upload a given S3 object to Observe | <pre>list(object({<br>    pattern = string<br>    headers = map(string)<br>  }))</pre> | `[]` | no |
| <a name="input_lambda_version"></a> [lambda\_version](#input\_lambda\_version) | Version of lambda binary to use | `string` | `"latest"` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The amount of memory that your function has access to. Increasing the function's memory also increases its CPU allocation.<br>The default value is 128 MB. The value must be a multiple of 64 MB. | `number` | `128` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Lambda resource | `string` | n/a | yes |
| <a name="input_observe_customer"></a> [observe\_customer](#input\_observe\_customer) | Observe Customer ID | `string` | n/a | yes |
| <a name="input_observe_domain"></a> [observe\_domain](#input\_observe\_domain) | Observe domain | `string` | `"observeinc.com"` | no |
| <a name="input_observe_token"></a> [observe\_token](#input\_observe\_token) | Observe Token | `string` | n/a | yes |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | The number of simultaneous executions to reserve for the function. | `number` | `100` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Retention in days of cloudwatch log group | `number` | `14` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 Bucket hosting lambda binary. If provided, overrides regional bucket map | `string` | `""` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | S3 object key for lambda binary. If provided, overrides s3\_key\_prefix | `string` | `""` | no |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | S3 key containing lambda binaries | `string` | `"lambda/observer"` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | S3 object version for lambda binary | `string` | `""` | no |
| <a name="input_s3_regional_buckets"></a> [s3\_regional\_buckets](#input\_s3\_regional\_buckets) | Map of AWS regions to lambda hosting S3 buckets | `map(any)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time that Lambda allows a function to run before stopping it.<br>The maximum allowed value is 900 seconds. | `number` | `60` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | VPC Config | <pre>object({<br>    security_groups = list(object({<br>      id = string<br>    }))<br>    subnets = list(object({<br>      arn = string<br>      id  = string<br>    }))<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function"></a> [lambda\_function](#output\_lambda\_function) | Observe Lambda function |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
