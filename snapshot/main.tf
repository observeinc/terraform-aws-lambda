locals {
  role_name     = regex(".*role/(?P<role_name>.*)$", var.lambda.lambda_function.role)["role_name"]
  function_name = regex(".*:function:(?P<function_name>.*)$", var.lambda.lambda_function.arn)["function_name"]

  iam_name_prefix     = var.iam_name_prefix != "" ? var.iam_name_prefix : var.eventbridge_name_prefix
  statement_id_prefix = var.statement_id_prefix != "" ? var.statement_id_prefix : local.iam_name_prefix
}

resource "aws_iam_policy" "this" {
  name_prefix = local.iam_name_prefix
  policy = jsonencode({

    Version = "2012-10-17"
    Statement = [
      {
        Action   = var.action,
        Effect   = "Allow"
        Resource = ["*"]
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
  schedule_expression = var.eventbridge_schedule_expression
  event_bus_name      = var.eventbridge_schedule_event_bus_name
}

resource "aws_cloudwatch_event_target" "target" {
  arn  = var.lambda.lambda_function.arn
  rule = aws_cloudwatch_event_rule.trigger.name
  input = jsonencode({
    snapshot = {
      include = var.action
      exclude = var.exclude
    }
  })
}

resource "aws_lambda_permission" "this" {
  statement_id_prefix = local.statement_id_prefix
  action              = "lambda:InvokeFunction"
  principal           = "events.amazonaws.com"
  function_name       = local.function_name
  source_arn          = aws_cloudwatch_event_rule.trigger.arn
}
