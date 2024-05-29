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
  nullable    = false
  default     = ""
}

variable "statement_id_prefix" {
  description = "Prefix used for Lambda permission statement ID"
  type        = string
  nullable    = false
  default     = ""
}

variable "eventbridge_name_prefix" {
  description = "Prefix used for EventBridge Rule"
  type        = string
  nullable    = false
  default     = "observe-lambda-snapshot-"
}

variable "action" {
  description = <<-EOF
  List of actions allowed by policy and periodically triggered. By default,
  this list contains all policies which the lambda can act upon. You should
  only override this list if you do not want to execute more actions as they
  become available in future lambda upgrades. If you instead wish to extend
  this list, or ignore a subset of actions, use \"include\" and \"exclude\".
  EOF
  type        = list(string)
  nullable    = false
  default = [
    "apigateway:Get*",
    "apigatewayv2:Get*",
    "autoscaling:Describe*",
    "cloudformation:Describe*",
    "cloudformation:List*",
    "cloudfront:List*",
    "dynamodb:Describe*",
    "dynamodb:List*",
    "ec2:Describe*",
    "ecs:Describe*",
    "ecs:List*",
    "eks:Describe*",
    "eks:List*",
    "elasticbeanstalk:Describe*",
    "elasticache:Describe*",
    "elasticfilesystem:Describe*",
    "elasticloadbalancing:Describe*",
    "elasticmapreduce:Describe*",
    "elasticmapreduce:List*",
    "events:List*",
    "firehose:Describe*",
    "firehose:List*",
    "iam:Get*",
    "iam:List*",
    "kinesis:Describe*",
    "kinesis:List*",
    "kms:Describe*",
    "kms:List*",
    "lambda:List*",
    "logs:Describe*",
    "organizations:Describe*",
    "organizations:List*",
    "rds:Describe*",
    "redshift:Describe*",
    "route53:List*",
    "s3:GetBucket*",
    "s3:List*",
    "secretsmanager:List*",
    "sns:Get*",
    "sns:List*",
    "sqs:Get*",
    "sqs:List*",
    "synthetics:Describe*",
    "synthetics:List*",
  ]
}

variable "include" {
  description = "List of actions to include in snapshot request."
  type        = list(string)
  nullable    = false
  default     = []
}

variable "exclude" {
  description = "List of actions to exclude from being executed on snapshot request."
  type        = list(string)
  nullable    = false
  default     = []
}

variable "resources" {
  description = "List of resources to scope policy to."
  type        = list(string)
  nullable    = false
  default     = ["*"]
}

variable "overrides" {
  description = "List of configuration overrides."
  type = list(object({
    action = string
    config = map(any)
  }))
  nullable = false
  default  = []
}

variable "eventbridge_schedule_event_bus_name" {
  description = "Event Bus for EventBridge scheduled events"
  type        = string
  nullable    = false
  default     = "default"
}

variable "eventbridge_schedule_expression" {
  description = "Rate at which snapshot is triggered. Must be valid EventBridge expression"
  type        = string
  nullable    = false
  default     = "rate(3 hours)"
}

variable "invoke_snapshot_on_start_enabled" {
  description = "Toggle invocation of snapshot from Cloudformation."
  type        = string
  nullable    = false
  default     = true
}
