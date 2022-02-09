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
  description = <<-EOF
    List of actions allowed by policy and periodically triggered. By default,
    this list contains all policies which the lambda can act upon. You should
    only override this list if you do not want to execute more actions as they
    become available in future lambda upgrades. If you instead wish to extend
    this list, or ignore a subset of actions, use \"include\" and \"exclude\".
  EOF
  type        = list(string)
  default = [
    "autoscaling:Describe*",
    "cloudformation:Describe*",
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
  ]
}

variable "include" {
  description = "List of actions to include in snapshot request."
  type        = list(string)
  default     = []
}

variable "exclude" {
  description = "List of actions to exclude from being executed on snapshot request."
  type        = list(string)
  default     = []
}

variable "resources" {
  description = "List of resources to scope policy to."
  type        = list(string)
  default     = ["*"]
}

variable "overrides" {
  description = "List of configuration overrides."
  type = list(object({
    action = string
    config = map(any)
  }))
  default = []
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
