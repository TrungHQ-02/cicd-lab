variable "global_variables" {
  type = any
}

variable "tags" {
  type = any
}

##################

variable "bucket_name" {
  description = "Name for the S3 bucket"
}

variable "bucket_ownership" {
  description = "Bucket object ownership"
  default     = "BucketOwnerPreferred"
}

variable "bucket_acl" {
  description = "Bucket access control list"
  default     = "private"
}

variable "bucket_policy_document" {
  description = "Bucket resource-based policy"
}

variable "index_doc_suffix" {
  description = "Index document when enabling website hosting"
}


variable "block_public_acls" {
  type    = bool
  default = true
}
variable "block_public_policy" {
  type    = bool
  default = true
}
variable "ignore_public_acls" {
  type    = bool
  default = true
}
variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "versioning_enabled" {
  type    = bool
  default = false
}
