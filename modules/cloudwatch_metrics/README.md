# Observe Lambda CloudWatch Metrics Configuration

This module configures the Observe Lambda to periodically pull metrics from AWS
CloudWatch. While configured in a similar manner to the "snapshot" module, the
CloudWatch Metrics functionality is distinct in that it does not simply log
responses to raw API calls. The Lambda takes a simplified configuration for
querying sets of metrics, and produces a list of metrics more readily consumed
than the raw API response from AWS.

This module sets up an event rule in EventBridge which triggers the Observe
Lambda periodically. Additionally, the module will add a policy to the existing
Lambda to ensure that all requested endpoints are accessible.

## Usage

```hcl
module "observe_lambda" {
  source           = "observeinc/lambda/aws"
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = random_pet.run.id
}

module "cloudwatch_metrics" {
  source = "observeinc/lambda/aws//modules/cloudwatch_metrics"
  lambda = module.observe_lambda

  filters = [
    {
        namespace = "AWS/RDS"
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
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
| [aws_cloudwatch_event_rule.trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_arn.function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_arn.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delay"></a> [delay](#input\_delay) | Collection delay in seconds. This delay accounts for the lag in metrics availability via Cloudwatch API. | `number` | `300` | no |
| <a name="input_eventbridge_name_prefix"></a> [eventbridge\_name\_prefix](#input\_eventbridge\_name\_prefix) | Prefix used for eventbridge rule | `string` | `"observe-lambda-metrics-"` | no |
| <a name="input_eventbridge_schedule_event_bus_name"></a> [eventbridge\_schedule\_event\_bus\_name](#input\_eventbridge\_schedule\_event\_bus\_name) | Event Bus for EventBridge scheduled events | `string` | `"default"` | no |
| <a name="input_filters"></a> [filters](#input\_filters) | List of filters. | <pre>list(object({<br>    namespace    = string<br>    list_mode    = optional(string)<br>    metric_names = optional(list(string))<br>    dimensions = optional(list(object({<br>      name  = string<br>      value = optional(string)<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | Prefix used for all created IAM roles and policies | `string` | `""` | no |
| <a name="input_interval"></a> [interval](#input\_interval) | Interval in seconds between collection runs. Use a multiple of period to avoid gaps. | `number` | `300` | no |
| <a name="input_lambda"></a> [lambda](#input\_lambda) | Observe Lambda module | <pre>object({<br>    lambda_function = object({<br>      arn  = string<br>      role = string<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_period"></a> [period](#input\_period) | Period in seconds between metric data points. Must be a multiple of 60. | `number` | `60` | no |
| <a name="input_statement_id_prefix"></a> [statement\_id\_prefix](#input\_statement\_id\_prefix) | Prefix used for Lambda permission statement ID | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
