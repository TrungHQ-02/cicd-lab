variable "user_defined_tags" {
  type        = map(string)
  description = "User defined tags"
  default     = {}
}

variable "resources" {
  type = any
}