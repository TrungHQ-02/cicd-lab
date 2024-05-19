variable "user_defined_tags" {
  type        = map(string)
  description = "User defined tags"
  default     = {}
}

variable "resource_configs" {
  type        = any
  description = "Resource configurations"
  default     = {}
}

