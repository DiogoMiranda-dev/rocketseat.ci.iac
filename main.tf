terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3" {
    bucket  = "diogomiranda-iac"
    region  = "us-east-2"
    key     = "state/terraform.tfstate"
    encrypt = true

    profile = "diogomiranda-dev"
  }
}
provider "aws" {
  profile = "diogomiranda-dev"
  region  = "us-east-2"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket        = "diogomiranda-iac"
  force_destroy = true
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    IAC = "True"
  }
}
resource "aws_s3_bucket_versioning" "terraform-state" {
  bucket = "diogomiranda-iac"
  versioning_configuration {
    status = "Enabled"
  }
}