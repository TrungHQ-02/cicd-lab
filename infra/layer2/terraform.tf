terraform {
  required_version = ">= 1.1.0"
  backend "s3" {
    profile        = "pmo"
    bucket         = "aws-trunghq13-lab-cicd-tfstate-bucket"
    key            = "l2-tfstate"
    region         = "us-west-1"
    dynamodb_table = "StateLocking-trunghq"
  }
}
