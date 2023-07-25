locals {
  iam_name_prefix     = var.iam_name_prefix != "" ? var.iam_name_prefix : var.eventbridge_name_prefix
  statement_id_prefix = var.statement_id_prefix != "" ? var.statement_id_prefix : local.iam_name_prefix
  action              = concat(var.action, var.include)
  role_resource       = split("/", data.aws_arn.role.resource)
  role_name           = local.role_resource[length(local.role_resource) - 1]
}

data "aws_arn" "role" {
  arn = var.lambda.lambda_function.role
}

data "aws_arn" "function" {
  arn = var.lambda.lambda_function.arn
}

resource "aws_iam_policy" "this" {
  name_prefix = local.iam_name_prefix
  policy = jsonencode({

    Version = "2012-10-17"
    Statement = [
      {
        Action   = local.action,
        Effect   = "Allow"
        Resource = var.resources
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = local.role_name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_cloudwatch_event_rule" "trigger" {
  name_prefix         = var.eventbridge_name_prefix
  description         = "Periodically trigger Observe Lambda to snapshot AWS API"
  schedule_expression = var.eventbridge_schedule_expression
  event_bus_name      = var.eventbridge_schedule_event_bus_name
}

resource "aws_cloudwatch_event_target" "target" {
  arn  = var.lambda.lambda_function.arn
  rule = aws_cloudwatch_event_rule.trigger.name
  input = jsonencode({
    snapshot = {
      include   = local.action
      exclude   = var.exclude
      overrides = var.overrides
    }
  })
}

resource "aws_lambda_permission" "this" {
  statement_id_prefix = local.statement_id_prefix
  action              = "lambda:InvokeFunction"
  principal           = "events.amazonaws.com"
  function_name       = trimprefix(data.aws_arn.function.resource, "function:")
  source_arn          = aws_cloudwatch_event_rule.trigger.arn
}

resource "aws_lambda_invocation" "snapshot" {
  count = var.invoke_snapshot_on_start_enabled ? 1 : 0
  # Note: Use function name from the arn to prevent requiring function_name
  function_name = trimprefix(data.aws_arn.function.resource, "function:")

  input = aws_cloudwatch_event_target.target.input
}

