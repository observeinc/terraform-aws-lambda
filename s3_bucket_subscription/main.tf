locals {
  role_name           = regex(".*role/(?P<role_name>.*)$", var.lambda.role)["role_name"]
  statement_id_prefix = var.statement_id_prefix != "" ? var.statement_id_prefix : var.iam_name_prefix
  bucket_arns         = var.bucket == null ? var.bucket_arns : [var.bucket.arn]
  bucket_count        = length(local.bucket_arns)
}

resource "aws_lambda_permission" "allow_bucket" {
  count               = local.bucket_count
  statement_id_prefix = local.statement_id_prefix
  action              = "lambda:InvokeFunction"
  function_name       = var.lambda.arn
  principal           = "s3.amazonaws.com"
  source_arn          = local.bucket_arns[count.index]
}

resource "aws_s3_bucket_notification" "notification" {
  count  = local.bucket_count
  bucket = trimprefix(local.bucket_arns[count.index], "arn:aws:s3:::")
  lambda_function {
    lambda_function_arn = var.lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.filter_prefix
    filter_suffix       = var.filter_suffix
  }
}

resource "aws_iam_policy" "s3_bucket_read" {
  name_prefix = var.iam_name_prefix
  # s3:ListBucket is not strictly required, but it allows us to receive a 404
  # instead of 403 error if an S3 object no longer exists by the time our
  # lambda function tries to retrieve it
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
     "Action": [
       "s3:ListBucket"
     ],
     "Effect": "Allow",
     "Resource": ${jsonencode(local.bucket_arns)},
     "Condition":{
       "StringLike":{
         "s3:prefix":["${var.filter_prefix}*"]
       }
     }
    },
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": ${jsonencode([for i in local.bucket_arns : format("%s/%s*", i, var.filter_prefix)])}
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_s3_bucket_read" {
  role       = local.role_name
  policy_arn = aws_iam_policy.s3_bucket_read.arn
}
