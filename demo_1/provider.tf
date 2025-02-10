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
    key            = "demo1/tf-state"
    dynamodb_table = "terraform_lock"
    encrypt        = true
    region         = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}