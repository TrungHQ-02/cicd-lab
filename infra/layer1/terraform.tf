terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    profile        = "pmo"
    bucket         = "aws-trunghq13-lab-cicd-tfstate-bucket"
    key            = "l1-tfstate"
    region         = "us-west-1"
    dynamodb_table = "StateLocking-trunghq"
  }
}
