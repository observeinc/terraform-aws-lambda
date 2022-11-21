# S3 Access Logs 

The configuration in this directory documents how to ingest S3 Access Logs.

The example creates two buckets: a `monitored` bucket, and an `access_logs`
bucket that will serve as a target for S3 access logs. This bucket is in turn
subscribed to the Observe Lambda. Every time an object is created in
`access_logs`, an `s3:ObjectCreated:*` event will trigger, invoking the Observe
Lambda to upload the contents of the object.

Note that S3 Access Logs may be delayed by up to a few hours. Please refer to
[AWS
documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ServerLogs.html) for more details.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.75 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.75 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_observe_lambda"></a> [observe\_lambda](#module\_observe\_lambda) | ../.. | n/a |
| <a name="module_observe_lambda_s3_subscription"></a> [observe\_lambda\_s3\_subscription](#module\_observe\_lambda\_s3\_subscription) | ../..//modules/s3_bucket_subscription | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.monitored](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.monitored](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Lambda name | `string` | n/a | yes |
| <a name="input_observe_customer"></a> [observe\_customer](#input\_observe\_customer) | Observe Customer ID | `string` | n/a | yes |
| <a name="input_observe_domain"></a> [observe\_domain](#input\_observe\_domain) | Observe Domain | `string` | `"observeinc.com"` | no |
| <a name="input_observe_token"></a> [observe\_token](#input\_observe\_token) | Observe token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_monitored"></a> [monitored](#output\_monitored) | S3 bucket monitored with access logs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
