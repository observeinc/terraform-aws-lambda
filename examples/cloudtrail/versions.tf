terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws    = ">= 2.68, <4.0.0"
    random = ">= 3.0.0"
    local  = ">= 2.0.0"
  }
}
