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

variable "lambda_s3_custom_rules" {
  description = "List of rules to evaluate how to upload a given S3 object to Obsere."
  type = list(object({
    pattern = string
    headers = map(string)
  }))
  default = []
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

variable "s3_bucket" {
  description = "S3 Bucket hosting lambda binary. If provided, overrides regional bucket map"
  type        = string
  default     = ""
}

variable "s3_key" {
  description = "S3 object key for lambda binary. If provided, overrides s3_key_prefix"
  type        = string
  default     = ""
}

variable "s3_object_version" {
  description = "S3 object version for lambda binary"
  type        = string
  default     = ""
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

variable "lambda_envvars" {
  description = "Environment variables"
  type        = map(any)
  default     = {}
}

variable "vpc_config" {
  description = "VPC Config"
  type = object({
    security_groups = list(object({
      id = string
    }))
    subnets = list(object({
      arn = string
      id  = string
    }))
  })
  default = null
}

variable "dead_letter_queue_destination" {
  type        = string
  default     = null
  description = "Send failed events/function executions to a dead letter queue arn sns or sqs"
}
