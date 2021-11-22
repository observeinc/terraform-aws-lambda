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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.68 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudtrail"></a> [cloudtrail](#module\_cloudtrail) | cloudposse/cloudtrail/aws | 0.15.0 |
| <a name="module_cloudtrail_s3_bucket"></a> [cloudtrail\_s3\_bucket](#module\_cloudtrail\_s3\_bucket) | cloudposse/cloudtrail-s3-bucket/aws | 0.15.0 |
| <a name="module_observe_lambda"></a> [observe\_lambda](#module\_observe\_lambda) | ../.. | n/a |
| <a name="module_observe_lambda_s3_subscription"></a> [observe\_lambda\_s3\_subscription](#module\_observe\_lambda\_s3\_subscription) | ../../s3_bucket_subscription | n/a |

## Resources

| Name | Type |
|------|------|
| [random_pet.run](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_observe_customer"></a> [observe\_customer](#input\_observe\_customer) | Observe Customer ID | `string` | n/a | yes |
| <a name="input_observe_domain"></a> [observe\_domain](#input\_observe\_domain) | Observe Domain | `string` | `"observeinc.com"` | no |
| <a name="input_observe_token"></a> [observe\_token](#input\_observe\_token) | Observe token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | ID for S3 bucket containing CloudTrail logs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
