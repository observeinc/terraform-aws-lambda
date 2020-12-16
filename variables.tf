variable "name" {
  description = "Name of Lambda resource"
  type        = string
}

variable "observe_customer" {
  description = "Observe Customer ID"
  type        = string
}

variable "observe_token" {
  description = "Observe Token"
  type        = string
}

# Optional input variables
variable "observe_domain" {
  description = "Observe domain"
  type        = string
  default     = "observeinc.com"
}

variable "lambda_version" {
  description = "Version of lambda binary to use"
  type        = string
  default     = "latest"
}

variable "s3_key_prefix" {
  description = "S3 key containing lambda binaries"
  type        = string
  default     = "lambda/observer"
}

variable "s3_regional_buckets" {
  description = "Map of AWS regions to lambda hosting S3 buckets"
  type        = map(any)
  default     = {}
}

variable "description" {
  description = "Lambda description"
  type        = string
  default     = "Lambda function to forward events towards Observe"
}

variable "memory_size" {
  description = <<-EOF
    The amount of memory that your function has access to. Increasing the function's memory also increases its CPU allocation.
    The default value is 128 MB. The value must be a multiple of 64 MB.
  EOF
  type        = number
  default     = 128
}

variable "timeout" {
  description = <<-EOF
    The amount of time that Lambda allows a function to run before stopping it.
    The maximum allowed value is 900 seconds.
  EOF
  type        = number
  default     = 60
}

variable "reserved_concurrent_executions" {
  description = "The number of simultaneous executions to reserve for the function."
  type        = number
  default     = 100
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "iam_name_prefix" {
  description = "Prefix used for all created IAM roles and policies"
  type        = string
  default     = "observe-lambda-"
}

variable "kms_key_arn" {
  description = <<-EOF
    The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your function's environment variables.
    If it's not provided, AWS Lambda uses a default service key.
  EOF
  type        = string
  default     = ""
}

variable "lambda_iam_role_arn" {
  description = "ARN of IAM role to use for Lambda"
  type        = string
  default     = ""
}

variable "retention_in_days" {
  description = "Retention in days of cloudwatch log group"
  type        = number
  default     = 14
}
