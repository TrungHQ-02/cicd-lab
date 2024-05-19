# variables.tf

# variable "region" {
#   description = "AWS region where the EKS cluster will be created"
# }

variable "cluster" {
  type = object({
    cluster_name = string
    role_arn     = string
    vpc_config = object({
      subnet_ids         = list(string)
      security_group_ids = list(string)
    })
  })
}

variable "aws_eks_node_group" {
  type = object({
    node_group_name = string
    node_role_arn   = string
    node_count      = number
    instance_types  = list(string)
    capacity_type   = string
  })
}


variable "aws_eks_addon" {
  type = map(object({
    addon_name    = string
    addon_version = optional(string)
  }))
}

variable "tags" {

}

variable "global_variables" {

}

# variable "cluster_name" {
#   description = "Name of the EKS cluster"
# }

# variable "cluster_version" {
#   description = "Version of the Kubernetes cluster. Defaults to latest."
# }

# variable "subnets" {
#   type        = list(string)
#   description = "List of subnet IDs where the EKS cluster will be deployed"
# }

# variable "node_group_desired_capacity" {
#   description = "Desired capacity of the node group"
# }

# variable "node_group_max_capacity" {
#   description = "Maximum capacity of the node group"
# }

# variable "node_group_min_capacity" {
#   description = "Minimum capacity of the node group"
# }

# variable "node_group_instance_type" {
#   description = "Instance type of the nodes in the node group"
# }

# variable "node_group_key_name" {
#   description = "SSH key name to be used for the nodes"
# }

# variable "environment" {
#   description = "Environment tag for the resources"
# }
