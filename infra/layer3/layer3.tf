
module "tagging" {
  source = "../module/tagging"

  user_defined_tags = var.user_defined_tags
}

module "global_variables" {
  source = "../module/global_variables"
}

module "eks" {
  source             = "../module/eks"
  cluster            = var.resource_configs.eks_configs.cluster
  aws_eks_node_group = var.resource_configs.eks_configs.aws_eks_node_group
  aws_eks_addon      = var.resource_configs.eks_configs.aws_eks_addon
  tags               = module.tagging.tags
  global_variables   = module.global_variables.global_variables
  depends_on         = [module.iam]
}

module "iam" {
  source             = "../module/iam"
  for_each           = var.resource_configs.role
  map_policy_objects = each.value.map_policy_objects
  role_object        = each.value.role_object
  tags               = module.tagging.tags
  global_variables   = module.global_variables.global_variables
}
