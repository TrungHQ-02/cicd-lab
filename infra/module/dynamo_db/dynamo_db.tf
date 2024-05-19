resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.dynamodb_table_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key

  dynamic "attribute" {
    for_each = var.attribute_maps
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }


  tags = var.tags
}
