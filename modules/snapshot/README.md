# Observe Lambda snapshot configuration

The Observe lambda is capable of pulling data from the AWS API on demand. This
module sets up an event rule in EventBridge which triggers the Observe Lambda
periodically. Additionally, the module will add a policy to the existing lambda
to ensure that all requested endpoints are accessible.

## Usage

```hcl
module "observe_lambda" {
  source                      = "observeinc/lambda/aws"
  observe_collection_endpoint = var.observe_collection_endpoint
  observe_token               = var.observe_token
  name                        = random_pet.run.id
}

module "observe_lambda_snapshot" {
  source = "observeinc/lambda/aws//modules/snapshot"
  lambda = module.observe_lambda
}
```

### Requesting a subset of actions

By omission, the module will attempt to collect all supported API actions. You
can override this list using the `action` variable. For example, to exclusively
collect data from EC2 endpoints beginning with `Describe`, you would use:

```hcl
module "observe_lambda_snapshot" {
  source = "observeinc/lambda/aws//modules/snapshot"
  lambda = module.observe_lambda
  action = [
    "ec2:Describe*"
  ]
}
```

Additionally, you can exclude actions from being performed using the `exclude`
variable.

```hcl
module "observe_lambda_snapshot" {
  source = "observeinc/lambda/aws//modules/snapshot"
  lambda = module.observe_lambda
  action = [
    "ec2:Describe*"
  ]
  exclude = [
    "ec2:DescribeVpcs"
  ]
}
```

Both `action` and `exclude` support the same format: a list of string patterns
which can be wildcarded using `*`. Wildcards are only supported as suffixes -
`*` inserted anywhere but the end of a string will be treated literally.

An important usecase for tweaking the set of actions is if you want to shard
requests across multiple lambda invocations. For accounts with many resources,
the default invocation may exceed the timeout configured for the lambda. Rather
than increase lambda timeout, we recommend using multiple instantiations of
this module, each one covering a disjoint set of endpoints, in order to spread
the load across lambda calls. For example:

```hcl
locals = {
    subset = [
        "iam:Get*",
        "iam:List*",
        "ec2:Describe*",
    ]
}
# Collect from all endpoints in subset
module "observe_lambda_snapshot_a" {
  source = "observeinc/lambda/aws//modules/snapshot"
  lambda = module.observe_lambda
  action = local.partial
}

# Collect from all other endpoints
module "observe_lambda_snapshot_b" {
  source = "observeinc/lambda/aws//modules/snapshot"
  lambda  = module.observe_lambda
  exclude = local.partial
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.73 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_invocation.snapshot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_invocation) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_arn.function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_arn.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | List of actions allowed by policy and periodically triggered. By default,<br>this list contains all policies which the lambda can act upon. You should<br>only override this list if you do not want to execute more actions as they<br>become available in future lambda upgrades. If you instead wish to extend<br>this list, or ignore a subset of actions, use \"include\" and \"exclude\". | `list(string)` | <pre>[<br>  "apigateway:Get*",<br>  "apigatewayv2:Get*",<br>  "autoscaling:Describe*",<br>  "cloudformation:Describe*",<br>  "cloudformation:List*",<br>  "cloudfront:List*",<br>  "dynamodb:Describe*",<br>  "dynamodb:List*",<br>  "ec2:Describe*",<br>  "ecs:Describe*",<br>  "ecs:List*",<br>  "eks:Describe*",<br>  "eks:List*",<br>  "elasticbeanstalk:Describe*",<br>  "elasticache:Describe*",<br>  "elasticfilesystem:Describe*",<br>  "elasticloadbalancing:Describe*",<br>  "elasticmapreduce:Describe*",<br>  "elasticmapreduce:List*",<br>  "events:List*",<br>  "firehose:Describe*",<br>  "firehose:List*",<br>  "iam:Get*",<br>  "iam:List*",<br>  "kinesis:Describe*",<br>  "kinesis:List*",<br>  "kms:Describe*",<br>  "kms:List*",<br>  "lambda:List*",<br>  "logs:Describe*",<br>  "organizations:Describe*",<br>  "organizations:List*",<br>  "rds:Describe*",<br>  "redshift:Describe*",<br>  "route53:List*",<br>  "s3:GetBucket*",<br>  "s3:List*",<br>  "secretsmanager:List*",<br>  "sns:Get*",<br>  "sns:List*",<br>  "sqs:Get*",<br>  "sqs:List*",<br>  "synthetics:Describe*",<br>  "synthetics:List*"<br>]</pre> | no |
| <a name="input_eventbridge_name_prefix"></a> [eventbridge\_name\_prefix](#input\_eventbridge\_name\_prefix) | Prefix used for EventBridge Rule | `string` | `"observe-lambda-snapshot-"` | no |
| <a name="input_eventbridge_schedule_event_bus_name"></a> [eventbridge\_schedule\_event\_bus\_name](#input\_eventbridge\_schedule\_event\_bus\_name) | Event Bus for EventBridge scheduled events | `string` | `"default"` | no |
| <a name="input_eventbridge_schedule_expression"></a> [eventbridge\_schedule\_expression](#input\_eventbridge\_schedule\_expression) | Rate at which snapshot is triggered. Must be valid EventBridge expression | `string` | `"rate(3 hours)"` | no |
| <a name="input_exclude"></a> [exclude](#input\_exclude) | List of actions to exclude from being executed on snapshot request. | `list(string)` | `[]` | no |
| <a name="input_iam_name_prefix"></a> [iam\_name\_prefix](#input\_iam\_name\_prefix) | Prefix used for all created IAM roles and policies | `string` | `""` | no |
| <a name="input_include"></a> [include](#input\_include) | List of actions to include in snapshot request. | `list(string)` | `[]` | no |
| <a name="input_invoke_snapshot_on_start_enabled"></a> [invoke\_snapshot\_on\_start\_enabled](#input\_invoke\_snapshot\_on\_start\_enabled) | Toggle invocation of snapshot from Cloudformation. | `string` | `true` | no |
| <a name="input_lambda"></a> [lambda](#input\_lambda) | Observe Lambda module | <pre>object({<br>    lambda_function = object({<br>      arn  = string<br>      role = string<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_overrides"></a> [overrides](#input\_overrides) | List of configuration overrides. | <pre>list(object({<br>    action = string<br>    config = map(any)<br>  }))</pre> | `[]` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | List of resources to scope policy to. | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_statement_id_prefix"></a> [statement\_id\_prefix](#input\_statement\_id\_prefix) | Prefix used for Lambda permission statement ID | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
