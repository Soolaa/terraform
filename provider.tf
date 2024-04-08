
# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"

}

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }
terraform {
  backend "s3" {
    bucket     = "sahar-state-file"
    key        = "state-file"
    region     = "us-east-1"
    access_key = "AKIAWEGVD6X3ZW6Y3KE3"
    secret_key = "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"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

