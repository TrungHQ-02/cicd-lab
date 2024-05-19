resource_configs = {
  s3_configs = {
    "remote_state_bucket" = {
      bucket_name            = "cicd-tfstate-bucket"
      bucket_ownership       = null
      bucket_acl             = null
      bucket_policy_document = null
      index_doc_suffix       = null
      versioning_enabled     = true
    }
  }

  dynamo_configs = {
    "state-lock-table" = {
      dynamodb_table_name = "StateLocking-trunghq"
      billing_mode        = "PROVISIONED"
      read_capacity       = 20
      write_capacity      = 20
      hash_key            = "LockID"

      # Additional attributes
      attribute_maps = {
        attribute1 = {
          name = "LockID"
          type = "S"
        }
      }
    }
  }
}

user_defined_tags = {
  "Layer"       = 0
  "Description" = "Provisioning infra for storing tfstate"
}
