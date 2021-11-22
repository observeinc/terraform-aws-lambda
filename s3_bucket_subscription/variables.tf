variable "lambda" {
  description = "Observe Lambda module"
  type = object({
    arn  = string
    role = string
  })
}

variable "bucket" {
  description = <<-EOF
    S3 bucket to subscribe to Observe Lambda.
    Deprecated: use bucket_arns instead.
  EOF
  type = object({
    arn = string
    id  = string
  })
  default = null
}

variable "bucket_arns" {
  description = "S3 bucket ARNs to subscribe to Observe Lambda"
  type        = list(string)
  default     = []
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
  default     = ""
}
