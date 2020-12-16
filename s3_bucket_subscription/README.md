# TBC

## Terraform versions

Terraform 0.12 and newer. Submit pull-requests to `main` branch.

## Usage

```hcl
resource "aws_s3_bucket" "bucket" {
  bucket        = "observe-kinesis-firehose-bucket"
  acl           = "private"
  force_destroy = true
}

module "observe_kinesis_firehose" {
  source = "github.com/observeinc/terraform-aws-kinesis-firehose"

  name                = "observe-kinesis-firehose"
  observe_customer    = "<id>"
  observe_token       = "<token>"
  s3_delivery_bucket  = aws_s3_bucket.bucket
}
```

This module will create a Kinesis Firehose delivery stream, as well as a role
and any required policies. An S3 bucket must be provided as a backup in case of
failed HTTP delivery.

## Configuring Kinesis Data Stream as a source

Optionally, you can specify a Kinesis Data Stream as a source to the Kinesis Firehose delivery stream. Only one data stream can be specified, and configuring this option disables all other inputs to your Kinesis Firehose.

```hcl
resource "aws_kinesis_stream" "example" {
  name             = "observe-kinesis-stream-example"
  shard_count      = 1
  retention_period = 24
}

module "observe_kinesis_firehose" {
  source = "github.com/observeinc/terraform-aws-kinesis-firehose"

  name                = "observe-kinesis-firehose"
  observe_customer    = "<id>"
  observe_token       = "<token>"
  s3_delivery_bucket  = aws_s3_bucket.bucket
  kinesis_stream      = aws_kinesis_stream.example
}
```

For more details, see the Kinesis Data Stream example.

## Configuring other sources

If you have not specified a Kinesis Data Stream as a source, you are free to configure other sources to put directly to your Kinesis Firehose delivery stream. You can use the module output policy when adding sources:

```hcl
resource "aws_iam_role_policy_attachment" "invoke_firehose" {
  role       = aws_iam_role.role.name
  policy_arn = module.observe_kinesis_firehose.firehose_iam_policy.arn
}
```

See the provided EventBridge example for a more complete example.


## Cloudwatch Logs

A Cloudwatch Log Group can optionally be provided in order to surface logs for
both S3 and HTTP endpoint delivery.

```hcl
resource "aws_cloudwatch_log_group" "group" {
  name              = "my-log-group"
  retention_in_days = 14
}

module "observe_kinesis_firehose" {
  source = "github.com/observeinc/terraform-aws-kinesis-firehose"

  name                 = "observe-kinesis-firehose"
  observe_customer     = "<id>"
  observe_token        = "<token>"
  s3_delivery_bucket   = aws_s3_bucket.bucket

  cloudwatch_log_group = aws_cloudwatch_log_group.group
}
```

Currently the module configures two output streams: one for S3 delivery, and another for HTTP endpoint delivery. You can disable either stream by setting `s3_delivery_cloudwatch_log_stream_name` and `http_endpoint_cloudwatch_log_stream_name` respectively to an empty string.

## Examples

* [EventBridge to Kinesis Firehose](https://github.com/observeinc/terraform-aws-kinesis-firehose/tree/main/examples/eventbridge)
* [Kinesis Data Stream to Kinesis Firehose](https://github.com/observeinc/terraform-aws-kinesis-firehose/tree/main/examples/kinesis)

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
| bucket | S3 bucket to subscribe to Observe Lambda | <pre>object({<br>    arn = string<br>    id  = string<br>  })</pre> | n/a | yes |
| filter\_prefix | Specifies object key name prefix on S3 bucket notifications. | `string` | `""` | no |
| filter\_suffix | Specifies object key name suffix on S3 bucket notifications. | `string` | `""` | no |
| iam\_name\_prefix | Prefix used for all created IAM roles and policies | `string` | `"observe-lambda-"` | no |
| lambda | Observe Lambda module | <pre>object({<br>    arn  = string<br>    role = string<br>  })</pre> | n/a | yes |
| statement\_id\_prefix | Prefix used for Lambda permission statement ID | `string` | `"observe-lambda-"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See LICENSE for full details.
