variable "observe_collection_endpoint" {
  description = "Observe Collection Endpoint, e.g https://123456789012.collect.observeinc.com"
  type        = string
}

variable "observe_token" {
  description = "Observe token"
  type        = string
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
