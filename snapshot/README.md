# Observe Lambda snapshot configuration

The Observe lambda is capable of pulling data from the AWS API on demand. This
module sets up an event rule in EventBridge which triggers the Observe Lambda
periodically. Additionally, the module will add a policy to the existing lambda
to ensure that all requested endpoints are accessible.

## Terraform versions

Terraform 0.12 and newer. Submit pull-requests to `main` branch.

## Usage

```hcl
module "observe_lambda" {
  source           = "../.."
  observe_customer = var.observe_customer
  observe_token    = var.observe_token
  observe_domain   = var.observe_domain
  name             = random_pet.run.id
}

module "observe_lambda_snapshot" {
  source = "../../snapshot"
  lambda = module.observe_lambda
}
```

### Requesting a subset of actions

By omission, the module will attempt to collect all supported API actions. You
can override this list using the `action` variable. For example, to exclusively
collect data from EC2 endpoints beginning with `Describe`, you would use:

```hcl
module "observe_lambda_snapshot" {
  source = "../../snapshot"
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
  source = "../../snapshot"
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
module "observe_lambda_snapshot" {
  source = "../../snapshot"
  lambda = module.observe_lambda
  action = local.partial
}

# Collect from all other endpoints
module "observe_lambda_snapshot" {
  source  = "../../snapshot"
  lambda  = module.observe_lambda
  exclude = local.partial
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
| action | List of actions to trigger | `list(string)` | <pre>[<br>  "ec2:Describe*",<br>  "iam:Get*",<br>  "iam:List*",<br>  "lambda:List*",<br>  "logs:Describe*",<br>  "rds:Describe*",<br>  "route53:List*",<br>  "route53:Describe*",<br>  "s3:List*"<br>]</pre> | no |
| eventbridge\_name\_prefix | Prefix used for eventbridge rule | `string` | `"observe-lambda-snapshot-"` | no |
| eventbridge\_schedule\_event\_bus\_name | Event Bus for EventBridge scheduled events | `string` | `"default"` | no |
| eventbridge\_schedule\_expression | Rate at which snapshot is triggered. Must be valid EventBridge expression | `string` | `"rate(3 hours)"` | no |
| exclude | List of actions to exclude | `list(string)` | `[]` | no |
| iam\_name\_prefix | Prefix used for all created IAM roles and policies | `string` | `"observe-lambda-snapshot-"` | no |
| lambda | Observe Lambda module | <pre>object({<br>    lambda_function = object({<br>      arn  = string<br>      role = string<br>    })<br>  })</pre> | n/a | yes |
| statement\_id\_prefix | Prefix used for Lambda permission statement ID | `string` | `"observe-lambda-snapshot"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
