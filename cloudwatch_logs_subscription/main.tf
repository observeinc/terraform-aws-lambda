locals {
  arn     = regex("arn:aws:lambda:(?P<region>[^:]+):(?P<account>[0-9]+)", var.lambda.arn)
  region  = local.arn["region"]
  account = var.account != "" ? var.account : local.arn["account"]
}

resource "aws_lambda_permission" "permission" {
  count               = var.allow_all_log_groups ? 0 : length(var.log_group_names)
  action              = "lambda:InvokeFunction"
  function_name       = var.lambda.function_name
  principal           = format("logs.%s.amazonaws.com", local.region)
  source_arn          = format("arn:aws:logs:%s:%s:log-group:%s:*", local.region, local.account, var.log_group_names[count.index])
  statement_id_prefix = var.statement_id_prefix
}

resource "aws_lambda_permission" "permission_allow_all" {
  count               = var.allow_all_log_groups ? 1 : 0
  action              = "lambda:InvokeFunction"
  function_name       = var.lambda.function_name
  principal           = format("logs.%s.amazonaws.com", local.region)
  source_arn          = format("arn:aws:logs:%s:%s:log-group:*:*", local.region, local.account)
  statement_id_prefix = var.statement_id_prefix
}

resource "aws_cloudwatch_log_subscription_filter" "subscription_filter" {
  count           = length(var.log_group_names)
  name            = var.filter_name
  log_group_name  = var.log_group_names[count.index]
  filter_pattern  = var.filter_pattern
  destination_arn = var.lambda.arn

  depends_on = [aws_lambda_permission.permission, aws_lambda_permission.permission_allow_all]
}
