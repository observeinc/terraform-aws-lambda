variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

variable "exported_prefix" {
  description = "Key prefix which logs are to be written to"
  type        = string
  nullable    = false
  default     = ""
}

variable "logging" {
  description = "Enable S3 access log collection"
  type        = bool
  nullable    = false
  default     = false
}

variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  nullable    = false
  default     = []
}

variable "force_destroy" {
  description = "Destroy all objects when deleting bucket"
  type        = bool
  nullable    = false
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  nullable    = false
  default     = {}
}
