terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform_lock"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key = "LockID"
}

resource "aws_s3_bucket" "rrsch_terraform" {
  bucket = "rrsch-terraform"
}

resource "aws_s3_bucket_versioning" "rrsch_terraform_versioning" {
  bucket = "rrsch-terraform"
  versioning_configuration {
    status = "Enabled"
  }
}