terraform {
  required_version = "1.10.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

  }
}

terraform {
  backend "s3" {
    bucket         = "terraformbackup020625"
    key            = "kaiser/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "kaiser_statefile"
  }
}


provider "aws" {
  region                   = var.region
  shared_credentials_files = ["C:/Users/rahul/.aws/credentials"]
}