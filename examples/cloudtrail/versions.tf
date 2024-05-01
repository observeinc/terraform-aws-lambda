terraform {
  required_version = ">= 1.1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.68"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0.0"
    }
  }
}
