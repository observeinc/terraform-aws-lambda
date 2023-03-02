locals {
  role_name           = regex(".*role/(?P<role_name>.*)$", var.lambda.role)["role_name"]
  statement_id_prefix = var.statement_id_prefix != "" ? var.statement_id_prefix : var.iam_name_prefix
}

resource "aws_lambda_permission" "allow_bucket" {
  for_each            = var.bucket_arns
  statement_id_prefix = local.statement_id_prefix
  action              = "lambda:InvokeFunction"
  function_name       = var.lambda.arn
  principal           = "s3.amazonaws.com"
  source_arn          = each.key
}

resource "aws_s3_bucket_notification" "notification" {
  for_each = var.bucket_arns
  bucket   = trimprefix(each.key, "arn:aws:s3:::")
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
     "Resource": ${jsonencode(var.bucket_arns)},
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
      "Resource": ${jsonencode([for i in var.bucket_arns : format("%s/%s*", i, var.filter_prefix)])}
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_s3_bucket_read" {
  role       = local.role_name
  policy_arn = aws_iam_policy.s3_bucket_read.arn
}
