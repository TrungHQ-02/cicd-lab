module "tagging" {
  source            = "../module/tagging"
  user_defined_tags = var.user_defined_tags
}

module "global_variables" {
  source = "../module/global_variables"
}

module "networking-vpc" {
  source               = "../module/networking/vpc"
  tags                 = module.tagging.tags
  global_variables     = module.global_variables.global_variables
  for_each             = var.resources.network
  enable_in_vpc        = each.value.enable_in_vpc
  nat_subnet_key       = each.value.nat_subnet_key
  connectivity_type    = each.value.connectivity_type
  vpc_cidr_block       = each.value.vpc_cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support   = each.value.enable_dns_support
  map_rt_objects       = each.value.map_rt_objects
  map_subnet_objects   = each.value.map_subnet_objects
}

module "networking-sg" {
  source           = "../module/networking/security-group"
  tags             = module.tagging.tags
  global_variables = module.global_variables.global_variables
  for_each         = var.resources.security_groups
  map_sg_objects   = each.value.map_sg_objects
  depends_on       = [module.networking-vpc]
}

