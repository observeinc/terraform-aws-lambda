variable "lambda" {
  description = "Observe Lambda module"
  type = object({
    lambda_function = object({
      arn  = string
      role = string
    })
  })
}

variable "iam_name_prefix" {
  description = "Prefix used for all created IAM roles and policies"
  type        = string
  default     = ""
}

variable "statement_id_prefix" {
  description = "Prefix used for Lambda permission statement ID"
  type        = string
  default     = ""
}

variable "eventbridge_name_prefix" {
  description = "Prefix used for eventbridge rule"
  type        = string
  default     = "observe-lambda-snapshot-"
}

variable "action" {
  description = "List of actions to trigger"
  type        = list(string)
  default = [
    "dynamodb:List*",
    "dynamodb:Describe*",
    "ec2:Describe*",
    "ecs:List*",
    "ecs:Describe*",
    "elasticache:Describe*",
    "elasticloadbalancing:Describe*",
    "firehose:List*",
    "firehose:Describe*",
    "kinesis:List*",
    "kinesis:Describe*",
    "iam:Get*",
    "iam:List*",
    "lambda:List*",
    "logs:Describe*",
    "rds:Describe*",
    "redshift:Describe*",
    "route53:List*",
    "s3:List*",
    "sns:List*",
    "sns:Get*",
    "sqs:List*",
    "sqs:Get*",
  ]
}

variable "exclude" {
  description = "List of actions to exclude"
  type        = list(string)
  default     = []
}

variable "eventbridge_schedule_event_bus_name" {
  description = "Event Bus for EventBridge scheduled events"
  type        = string
  default     = "default"
}

variable "eventbridge_schedule_expression" {
  description = "Rate at which snapshot is triggered. Must be valid EventBridge expression"
  type        = string
  default     = "rate(3 hours)"
}
