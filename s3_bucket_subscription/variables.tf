variable "lambda" {
  description = "Observe Lambda module"
  type = object({
    arn  = string
    role = string
  })
}

variable "bucket" {
  description = "S3 bucket to subscribe to Observe Lambda"
  type = object({
    arn = string
    id  = string
  })
}

variable "filter_prefix" {
  description = "Specifies object key name prefix on S3 bucket notifications."
  type        = string
  default     = ""
}

variable "filter_suffix" {
  description = "Specifies object key name suffix on S3 bucket notifications."
  type        = string
  default     = ""
}

variable "iam_name_prefix" {
  description = "Prefix used for all created IAM roles and policies"
  type        = string
  default     = "observe-lambda-"
}

variable "statement_id_prefix" {
  description = "Prefix used for Lambda permission statement ID"
  type        = string
  default     = "observe-lambda-"
}
