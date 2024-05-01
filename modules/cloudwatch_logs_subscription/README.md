# Cloudwatch Logs to Observe Lambda

Given a list of Cloudwatch Log Group names and an Observe lambda function, this
module subscribes each Log Group to a lambda, creating necessary permissions
along the way.

By omission, the module abides by the principle of least privilege, only
granting permission to invoke the lambda function to the provided cloudwatch
log groups. If you have many log groups, the resulting lambda policy may
overrun AWS limits. In such cases, you can set the `allow_all_log_groups`
variable to use a single, more permissive policy, rather than a large set of
restrictive ones.

## Usage

```hcl
resource "aws_cloudwatch_log_group" "group" {
  name_prefix = random_pet.run.id
}

module "observe_lambda" {
  source                      = "observeinc/lambda/aws"
  observe_collection_endpoint = var.observe_collection_endpoint
  observe_token               = var.observe_token
  name                        = random_pet.run.id
}

module "observe_lambda_cloudwatch_logs_subscription" {
  source = "observeinc/lambda/aws//modules/cloudwatch_logs_subscription"
  lambda = module.observe_lambda.lambda_function
  log_group_names = [
    aws_cloudwatch_log_group.group.name
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.1 |
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
| [aws_cloudwatch_log_subscription_filter.subscription_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_lambda_permission.permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.permission_allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_arn.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | Account ID for log groups. If empty, account is assumed to be the same as lambda | `string` | `""` | no |
| <a name="input_allow_all_log_groups"></a> [allow\_all\_log\_groups](#input\_allow\_all\_log\_groups) | Create a single permission allowing lambda to be triggered by any log group.<br>This works around policy limits when subscribing many log groups to a single lambda." | `bool` | `false` | no |
| <a name="input_filter_name"></a> [filter\_name](#input\_filter\_name) | Filter name | `string` | `"observe-filter"` | no |
| <a name="input_filter_pattern"></a> [filter\_pattern](#input\_filter\_pattern) | The filter pattern to use. For more information, see [Filter and Pattern Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html) | `string` | `""` | no |
| <a name="input_lambda"></a> [lambda](#input\_lambda) | Observe Lambda module | <pre>object({<br>    arn           = string<br>    function_name = string<br>  })</pre> | n/a | yes |
| <a name="input_log_group_names"></a> [log\_group\_names](#input\_log\_group\_names) | Cloudwatch Log Group names to subscribe to Observe Lambda | `list(string)` | n/a | yes |
| <a name="input_statement_id_prefix"></a> [statement\_id\_prefix](#input\_statement\_id\_prefix) | Prefix used for Lambda permission statement ID | `string` | `"observe-lambda"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
