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
| terraform | >= 0.12.21 |
| aws | >= 2.68 |
| random | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68 |
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
| bucket | S3 bucket subscribed to Observe Lambda |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
