
module "tagging" {
  source = "../module/tagging"

  user_defined_tags = var.user_defined_tags
}

module "global_variables" {
  source = "../module/global_variables"
}

module "argocd" {
  source       = "../module/argo/argo-cd-setup"
  cluster_name = var.resource_configs.eks_configs.cluster_name
  region       = var.resource_configs.eks_configs.region
}

