terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket         = "rrsch-terraform"
    key            = "demo"
    dynamodb_table = "terraform_lock"
    encrypt        = true
    region         = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"

  # ==============================================================
  # examples for custom authentication configuration
  # ==============================================================
  #
  # access_key = XXXXXXXXXXXXXXX
  # secret_key = XXXXXXXXXXXXXXX
  #
  # --------------------------------------------------------------
  #
  # shared_config_files = [ "~/.aws/config" ]
  # shared_credentials_files = [~/.aws/credentials]
  #
  # --------------------------------------------------------------
  #
  # assume_role {
  #   role_arn = "arn:aws:iam::${var.account_id}:role/terraform"
  # }
  #
  # --------------------------------------------------------------
  # Refer documentation for credential precedence order
  # --------------------------------------------------------------
}