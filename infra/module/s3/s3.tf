resource "aws_s3_bucket" "bucket" {
  bucket        = local.prefix_name
  force_destroy = true

  tags = merge(var.tags, {
    Name : var.bucket_name
  })
}

resource "aws_s3_bucket_ownership_controls" "example" {
  count = var.bucket_ownership != null ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = var.bucket_ownership
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  count = var.bucket_acl != null ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_acl" "example" {
  count = var.bucket_acl != null ? 1 : 0

  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.bucket.id
  acl    = var.bucket_acl
}

resource "aws_s3_bucket_policy" "example" {
  count = var.bucket_policy_document != null ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode(var.bucket_policy_document)
}

resource "aws_s3_bucket_website_configuration" "website_bucket" {
  count = var.index_doc_suffix != null ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.index_doc_suffix
  }
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioning_enabled ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
