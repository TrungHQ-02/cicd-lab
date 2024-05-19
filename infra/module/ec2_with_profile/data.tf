data "aws_subnet" "example" {
  count = var.subnet_name != null ? 1 : 0
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}

data "aws_iam_role" "example" {
  count = var.enable_role == true ? 1 : 0
  name  = var.role_name
}


data "aws_security_group" "security_group" {
  filter {
    name   = "tag:Name"
    values = ["*${var.sg_name}*"]
  }
}

