# CloudTrail to S3 to Observe Lambda

The configuration in this directory documents one manner of ingesting
AWS CloudTrail logs into Observe.

A CloudTrail is configured to periodically dump data into an S3 bucket. The
selected S3 bucket is in turn configured to trigger the Observe Lambda on every
object created. On invocation, the lambda will attempt to read the created
object from the S3 bucket and post it to Observe.

Note: due to version constraints on the modules used, this example does not
currently support Terraform versions >= 0.14.0

## Usage

To run this example, execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this will create AWS resources - once you are done, run `terraform destroy`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.21 |
| aws | >= 2.68 |
| local | >= 2.0.0 |
| random | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| random | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| observe\_customer | Observe Customer ID | `string` | n/a | yes |
| observe\_domain | Observe Domain | `string` | `"observeinc.com"` | no |
| observe\_token | Observe token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_id | ID for S3 bucket containing CloudTrail logs |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
