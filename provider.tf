terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA37OXWYHXPUUEHQSL"
  secret_key = "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"
}
