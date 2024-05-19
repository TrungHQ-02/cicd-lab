locals {
  default_tags = {
    Region         = data.aws_region.current.name
    Environment    = "lab"
    Account        = "TrungHQ13"
    Project        = "cicd"
    Provisioned_by = "terraform"
  }

  user_defined_tags = var.user_defined_tags

  final_tags = merge(local.user_defined_tags, local.default_tags)
}


