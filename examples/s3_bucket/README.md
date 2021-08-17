# Lambda upload from S3 bucket

The configuration in this directory documents how to ingest files uploaded to
S3 into Observe via a Lambda. The example subscribes the Lambda to S3 bucket
notifications.

Upon being triggered by an `s3:ObjectCreated:*` event, the Lambda will attempt
to read the S3 key specified in the event, and submit the contents directly to
Observe. The file type will be infered based on file suffix.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.21 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.68 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.54.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_observe_lambda"></a> [observe\_lambda](#module\_observe\_lambda) | ../.. | n/a |
| <a name="module_observe_lambda_s3_subscription"></a> [observe\_lambda\_s3\_subscription](#module\_observe\_lambda\_s3\_subscription) | ../../s3_bucket_subscription | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [random_pet.run](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_filter_prefix"></a> [filter\_prefix](#input\_filter\_prefix) | Specifies object key name prefix on S3 bucket notifications. | `string` | `""` | no |
| <a name="input_filter_suffix"></a> [filter\_suffix](#input\_filter\_suffix) | Specifies object key name suffix on S3 bucket notifications. | `string` | `""` | no |
| <a name="input_observe_customer"></a> [observe\_customer](#input\_observe\_customer) | Observe Customer ID | `string` | n/a | yes |
| <a name="input_observe_domain"></a> [observe\_domain](#input\_observe\_domain) | Observe Domain | `string` | `"observeinc.com"` | no |
| <a name="input_observe_token"></a> [observe\_token](#input\_observe\_token) | Observe token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | S3 bucket subscribed to Observe Lambda |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
