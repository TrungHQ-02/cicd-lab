variable "global_variables" {
  type = any
}

variable "tags" {
  type = any
}

##########################

variable "subnet_name" {
  description = "Subnet name for the EC2 instance"
}


variable "role_name" {
  description = "Name of IAM role"
  type        = string
}

variable "sg_name" {
  description = "Security group name"
  type        = any
}

##########################

variable "enable_role" {
  # if enable_role = yes, you can attach a role to this ec2 instance via the following attributes
  type = bool
}

variable "has_key_pair" {
  type = bool
}

variable "has_ebs" {
  type = bool
}
variable "ami" {
  description = "AMI ID for the EC2 instance"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
}

variable "instance_type" {
  description = "Type of EC2 instance"
}

variable "ebs_volume_size" {
  description = "Size of the EBS volume (in GB)"
}

variable "ebs_device_name" {
  description = "Device name for the attached EBS volume (e.g., /dev/sdf)"
}

variable "user_data" {
  description = "User data to initialize the EC2"
  type        = any
}

variable "key_pair_name" {
  type = any
}

variable "key_pair_path" {
  type = any
}




