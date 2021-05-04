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
| terraform | >= 0.12.21 |
| aws | >= 2.68 |
| random | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Lambda name | `string` | n/a | yes |
| observe\_customer | Observe Customer ID | `string` | n/a | yes |
| observe\_domain | Observe Domain | `string` | `"observeinc.com"` | no |
| observe\_token | Observe token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| monitored | S3 bucket monitored with access logs |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
