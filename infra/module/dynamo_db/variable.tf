variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
}

variable "billing_mode" {
  description = "The billing mode for the DynamoDB table (PROVISIONED or PAY_PER_REQUEST)"
  default     = "PROVISIONED"
}

variable "read_capacity" {
  description = "The read capacity units for the DynamoDB table"
  default     = 20
}

variable "write_capacity" {
  description = "The write capacity units for the DynamoDB table"
  default     = 20
}

variable "hash_key" {
  description = "The attribute name to use as the hash (partition) key for the DynamoDB table"
}

variable "attribute_maps" {
  description = "A map of additional attributes for the DynamoDB table"
  type = map(object({
    name = string
    type = string
  }))
}

##########################################

variable "tags" {
  description = "A map of tags to apply to the DynamoDB table"
  type        = map(string)
}

variable "global_variables" {
  description = "A map of global variables"
  type        = map(string)
}
