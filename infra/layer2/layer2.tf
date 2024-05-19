module "tagging" {
  source            = "../module/tagging"
  user_defined_tags = var.user_defined_tags
}

module "global_variables" {
  source = "../module/global_variables"
}

#################################
#################################

module "iam_role" {
  source = "../module/iam"

  for_each = var.resource_configs.role

  global_variables = module.global_variables.global_variables
  tags             = module.tagging.tags

  #####################
  map_policy_objects = each.value.map_policy_objects
  role_object        = each.value.role_object
}

module "ec2" {
  source = "../module/ec2_with_profile"

  for_each         = var.resource_configs.ec2
  global_variables = module.global_variables.global_variables
  tags             = module.tagging.tags

  ###############
  ami           = each.value.ami
  instance_name = each.value.instance_name
  instance_type = each.value.instance_type
  user_data     = each.value.user_data
  subnet_name   = each.value.subnet_name

  has_key_pair  = each.value.has_key_pair
  key_pair_name = each.value.key_pair_name
  key_pair_path = each.value.key_pair_path

  sg_name = each.value.sg_name

  enable_role = each.value.enable_role
  role_name   = each.value.role_name


  has_ebs         = each.value.has_ebs
  ebs_volume_size = each.value.ebs_volume_size
  ebs_device_name = each.value.ebs_device_name

  depends_on = [module.iam_role]
}
