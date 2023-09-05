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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_observe_lambda"></a> [observe\_lambda](#module\_observe\_lambda) | ../.. | n/a |
| <a name="module_observe_lambda_s3_subscription"></a> [observe\_lambda\_s3\_subscription](#module\_observe\_lambda\_s3\_subscription) | ../..//modules/s3_bucket_subscription | n/a |
| <a name="module_observe_s3_bucket"></a> [observe\_s3\_bucket](#module\_observe\_s3\_bucket) | ../..//modules/s3_bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [random_pet.run](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_count"></a> [bucket\_count](#input\_bucket\_count) | Number of buckets to create and subscribe. | `number` | `1` | no |
| <a name="input_filter_prefix"></a> [filter\_prefix](#input\_filter\_prefix) | Specifies object key name prefix on S3 bucket notifications. | `string` | `null` | no |
| <a name="input_filter_suffix"></a> [filter\_suffix](#input\_filter\_suffix) | Specifies object key name suffix on S3 bucket notifications. | `string` | `null` | no |
| <a name="input_observe_collection_endpoint"></a> [observe\_collection\_endpoint](#input\_observe\_collection\_endpoint) | Observe Collection Endpoint, e.g https://123456789012.collect.observeinc.com | `string` | n/a | yes |
| <a name="input_observe_token"></a> [observe\_token](#input\_observe\_token) | Observe token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_buckets"></a> [buckets](#output\_buckets) | S3 buckets subscribed to Observe Lambda |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
