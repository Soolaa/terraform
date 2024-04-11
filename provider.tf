
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

  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

