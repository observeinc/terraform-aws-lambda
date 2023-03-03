variable "lambda" {
  description = "Observe Lambda module"
  type = object({
    arn  = string
    role = string
  })
}

variable "bucket_arns" {
  description = "S3 bucket ARNs to subscribe to Observe Lambda"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "filter_prefix" {
  description = "Specifies object key name prefix on S3 bucket notifications."
  type        = string
  nullable    = false
  default     = ""
}

variable "filter_suffix" {
  description = "Specifies object key name suffix on S3 bucket notifications."
  type        = string
  nullable    = false
  default     = ""
}

variable "iam_name_prefix" {
  description = "Prefix used for all created IAM roles and policies"
  type        = string
  nullable    = false
  default     = "observe-lambda-"
}

variable "statement_id_prefix" {
  description = "Prefix used for Lambda permission statement ID"
  type        = string
  nullable    = false
  default     = ""
}
