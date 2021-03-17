variable "lambda" {
  description = "Observe Lambda module"
  type = object({
    arn           = string
    function_name = string
  })
}

variable "log_group_names" {
  description = "Cloudwatch Log Group names to subscribe to Observe Lambda"
  type        = list(string)
}

variable "filter_pattern" {
  description = "The filter pattern to use. For more information, see [Filter and Pattern Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html)"
  type        = string
  default     = ""
}

variable "filter_name" {
  description = "Filter name"
  type        = string
  default     = "observe-filter"
}

variable "account" {
  description = "Account ID for log groups. If empty, account is assumed to be the same as lambda"
  type        = string
  default     = ""
}
