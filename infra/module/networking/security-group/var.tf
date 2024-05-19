variable "tags" {
  description = "Tagging for networking resource"
  type        = any
}

variable "global_variables" {
  type = any
}

variable "map_sg_objects" {
  type = map(object({
    name = string
    ingress = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = tuple([string])
    }))
    egress = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = tuple([string])
    }))
  }))

}