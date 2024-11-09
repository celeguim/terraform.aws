terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket" # The name of your S3 bucket
    key            = "DEV/terraform.tfstate"     # Path to the state file within the bucket
    region         = "us-west-2"                 # AWS region for both the bucket and table
    dynamodb_table = "terraform-lock-table"      # The DynamoDB table name for locking
    encrypt        = true                        # Encrypt state file in S3
  }
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}

# Create an S3 bucket for Terraform state storage
resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket" # Ensure this bucket name is globally unique
  acl    = "private"
  region = "us-west-2"

  versioning {
    enabled = true
  }
}

# Create a DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  # Enabling point-in-time recovery for extra data protection
  point_in_time_recovery {
    enabled = true
  }
}

resource "aws_instance" "example" {
  ami           = "ami-00634d7ae9b22b693"
  instance_type = "t2.micro"

  tags = {
    "Name" = "PreventDelete"
  }
  # Prevents this resource from being destroyed
  lifecycle {
    prevent_destroy = false
  }
}
