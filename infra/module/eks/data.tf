data "aws_subnet" "private_subnet0" {
  count = length(var.cluster.vpc_config.subnet_ids) != 0 ? 1 : 0
  filter {
    name   = "tag:Name"
    values = ["${local.prefix_name}-${var.cluster.vpc_config.subnet_ids[0]}"]
  }
}
data "aws_subnet" "private_subnet1" {
  count = length(var.cluster.vpc_config.subnet_ids) != 0 ? 1 : 0
  filter {
    name   = "tag:Name"
    values = ["${local.prefix_name}-${var.cluster.vpc_config.subnet_ids[1]}"]
  }
}

data "aws_security_groups" "security_group" {
  count = length(var.cluster.vpc_config.security_group_ids) != 0 ? 1 : 0
  filter {
    name   = "tag:Name"
    values = ["${local.prefix_name}-${var.cluster.vpc_config.security_group_ids[0]}"]
  }
}

data "aws_security_groups" "all_security_group" {
  count = length(var.cluster.vpc_config.security_group_ids)
  filter {
    name   = "tag:Name"
    values = ["${local.prefix_name}-${var.cluster.vpc_config.security_group_ids[count.index]}"]
  }
}

data "aws_iam_role" "admin" {
  count = var.cluster.role_arn != null ? 1 : 0
  name  = "${local.prefix_name}-${var.cluster.role_arn}"
}

data "aws_iam_role" "eks_cluster" {
  count = var.cluster.role_arn != null ? 1 : 0
  name  = "${local.prefix_name}-${var.cluster.role_arn}"
}

data "aws_iam_role" "eks-node-group" {
  count = var.aws_eks_node_group.node_role_arn != null ? 1 : 0
  name  = "${local.prefix_name}-${var.aws_eks_node_group.node_role_arn}"

}

locals {
  prefix_name = "${var.global_variables["project"]}-${var.global_variables["owner"]}-${var.global_variables["environment"]}"
}

