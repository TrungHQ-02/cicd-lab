module "tagging" {
  source = "../module/tagging"

  user_defined_tags = var.user_defined_tags
}

module "global_variables" {
  source = "../module/global_variables"
}

module "s3" {
  source   = "../module/s3"
  for_each = var.resource_configs.s3_configs

  # The bucket name will be
  #  ${var.global_variables["project"]}-
  #  ${var.global_variables["owner"]}-${var.global_variables["environment"]}-
  #  ${var.bucket_name}
  bucket_name             = each.value.bucket_name
  bucket_ownership        = each.value.bucket_ownership
  bucket_acl              = each.value.bucket_acl
  bucket_policy_document  = each.value.bucket_policy_document
  index_doc_suffix        = each.value.index_doc_suffix
  block_public_acls       = try(each.value.block_public_acls, null)
  block_public_policy     = try(each.value.block_public_policy, null)
  ignore_public_acls      = try(each.value.ignore_public_acls, null)
  restrict_public_buckets = try(each.value.restrict_public_buckets, null)
  versioning_enabled      = each.value.versioning_enabled

  # tagging from module tagging
  tags = module.tagging.tags

  # global variables from module global_variables
  global_variables = module.global_variables.global_variables
}

module "dynamo_db" {
  source   = "../module/dynamo_db"
  for_each = var.resource_configs.dynamo_configs

  dynamodb_table_name = each.value.dynamodb_table_name
  billing_mode        = each.value.billing_mode
  read_capacity       = each.value.read_capacity
  write_capacity      = each.value.write_capacity
  hash_key            = each.value.hash_key
  attribute_maps      = each.value.attribute_maps
  # tagging from module tagging
  tags = module.tagging.tags

  # global variables from module global_variables
  global_variables = module.global_variables.global_variables
}
