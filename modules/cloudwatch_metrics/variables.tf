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
  description = "Prefix used for eventbridge rule"
  type        = string
  nullable    = false
  default     = "observe-lambda-metrics-"
}

variable "interval" {
  description = "Interval in seconds between collection runs. Use a multiple of period to avoid gaps."
  type        = number
  nullable    = false
  default     = 300
  validation {
    condition     = var.interval >= 60 && var.interval <= 10800
    error_message = "interval must be in [60, 10800] (1 minute to 3 hours)"
  }
}

variable "period" {
  description = "Period in seconds between metric data points. Must be a multiple of 60."
  type        = number
  nullable    = false
  default     = 60
  validation {
    condition     = var.period >= 60 && var.period % 60 == 0
    error_message = "period must be at least 60 seconds, and a multiple of 60."
  }
}

variable "delay" {
  description = "Collection delay in seconds. This delay accounts for the lag in metrics availability via Cloudwatch API."
  type        = number
  nullable    = false
  default     = 300
}

variable "filters" {
  description = "List of filters."
  type = list(object({
    namespace    = string
    list_mode    = optional(string)
    metric_names = optional(list(string))
    dimensions = optional(list(object({
      name  = string
      value = optional(string)
    })))
  }))
}

variable "eventbridge_schedule_event_bus_name" {
  description = "Event Bus for EventBridge scheduled events"
  type        = string
  nullable    = false
  default     = "default"
}
