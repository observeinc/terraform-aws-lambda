variable "observe_customer" {
  description = "Observe Customer ID"
  type        = string
}

variable "observe_token" {
  description = "Observe token"
  type        = string
}

variable "observe_domain" {
  description = "Observe Domain"
  type        = string
  default     = null
}

variable "bucket_count" {
  description = "Number of buckets to create and subscribe."
  type        = number
  nullable    = false
  default     = 1
}

variable "filter_prefix" {
  description = "Specifies object key name prefix on S3 bucket notifications."
  type        = string
  default     = null
}

variable "filter_suffix" {
  description = "Specifies object key name suffix on S3 bucket notifications."
  type        = string
  default     = null
}
