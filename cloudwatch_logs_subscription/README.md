# Cloudwatch Logs to Observe Lambda

Given a list of Cloudwatch Log Group names and an Observe lambda function, this
module subscribes each Log Group to a lambda, creating necessary permissions
along the way.

Terraform 0.12 and newer. Submit pull-requests to `main` branch.

## Usage

```hcl
resource "aws_cloudwatch_log_group" "group" {
  name_prefix = random_pet.run.id
}

module "observe_lambda" {
  source           = "github.com/observeinc/terraform-aws-lambda"
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = random_pet.run.id
}

module "observe_lambda_cloudwatch_logs_subscription" {
  source = "github.com/observeinc/terraform-aws-lambda//cloudwatch_logs_subscription"
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
| terraform | >= 0.12.21 |
| aws | >= 2.68 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account | Account ID for log groups. If empty, account is assumed to be the same as lambda | `string` | `""` | no |
| filter\_name | Filter name | `string` | `"observe-filter"` | no |
| filter\_pattern | The filter pattern to use. For more information, see [Filter and Pattern Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html) | `string` | `""` | no |
| lambda | Observe Lambda module | <pre>object({<br>    arn           = string<br>    function_name = string<br>  })</pre> | n/a | yes |
| log\_group\_names | Cloudwatch Log Group names to subscribe to Observe Lambda | `list(string)` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
