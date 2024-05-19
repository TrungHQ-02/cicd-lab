variable "global_variables" {
  type = any
}


variable "tags" {
  type = any
}

variable "map_policy_objects" {
  type = map(object({
    name        = string
    description = string
    policy      = any
  }))
}

variable "role_object" {
  type = object({
    name               = string
    assume_role_policy = any
  })
}

