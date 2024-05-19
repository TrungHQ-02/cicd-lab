variable "global_variables" {
  type = any
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the vpc"
}

variable "enable_dns_hostnames" {
  description = "Enable dns hostname on the vpc"
}

variable "enable_dns_support" {
  description = "Enable dns support on the vpc"
}

variable "tags" {
  description = "Tagging for resource networking"
  type        = any
}

variable "map_rt_objects" {
  description = "Route table for subnet"
  type = map(object({
    name       = string
    cidr_block = string
    is_public  = bool
  }))
}

variable "map_subnet_objects" {
  description = "Subnet defined in VPC"
  type = map(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    route_table_key         = string
  }))
}

variable "enable_in_vpc" {
  description = "Elastic IP for NatGW"
}

variable "nat_subnet_key" {
  description = "Nat assign to subnet followed by key"
}

variable "connectivity_type" {
  description = "Connectivity type for NatGW"
}

