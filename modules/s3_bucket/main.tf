locals {
  bucket_arn      = "arn:aws:s3:::${var.bucket_name}"
  aws_logs_arn    = "${local.bucket_arn}/${local.exported_prefix}AWSLogs/${data.aws_caller_identity.current.account_id}/*"
  exported_prefix = var.exported_prefix != "" ? format("%s/", trimsuffix(var.exported_prefix, "/")) : ""
}

data "aws_caller_identity" "current" {}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.7.0"

  bucket        = var.bucket_name
  acl           = "log-delivery-write"
  force_destroy = var.force_destroy

  lifecycle_rule = var.lifecycle_rule

  logging = var.logging ? {
    target_bucket = var.bucket_name
    target_prefix = "${local.exported_prefix}S3ServerLogs/"
  } : {}

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  attach_elb_log_delivery_policy = true
  attach_lb_log_delivery_policy  = true
  attach_policy                  = true
  policy                         = data.aws_iam_policy_document.bucket.json

  tags = var.tags
}

data "aws_redshift_service_account" "this" {}

data "aws_iam_policy_document" "bucket" {
  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      local.aws_logs_arn,
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      local.bucket_arn,
    ]
  }

  statement {
    sid    = "AWSConfigWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      local.aws_logs_arn,
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid    = "AWSConfigAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      local.bucket_arn,
    ]
  }

  statement {
    sid    = "AWSRedshiftWrite"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_redshift_service_account.this.arn]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      local.aws_logs_arn,
    ]
  }

  statement {
    sid    = "AWSRedshiftAclCheck"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_redshift_service_account.this.arn]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      local.bucket_arn,
    ]
  }
}
