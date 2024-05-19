resources = {
  network = {
    "networking-infra" = {
      vpc_cidr_block       = "10.0.0.0/16"
      enable_dns_hostnames = true
      enable_dns_support   = true
      enable_in_vpc        = true
      map_subnet_objects = {
        public_subnet_01 = {
          name                    = "public_subnet_01"
          cidr_block              = "10.0.0.0/24"
          availability_zone       = "us-west-1a"
          map_public_ip_on_launch = true
          route_table_key         = "public_rt"
        }
        public_subnet_02 = {
          name                    = "public_subnet_02"
          cidr_block              = "10.0.4.0/24"
          availability_zone       = "us-west-1c"
          map_public_ip_on_launch = true
          route_table_key         = "public_rt"
        }
        private_subnet_01 = {
          name                    = "private_subnet_01"
          cidr_block              = "10.0.2.0/24"
          availability_zone       = "us-west-1a"
          map_public_ip_on_launch = false
          route_table_key         = "private_rt"
        }
        private_subnet_02 = {
          name                    = "private_subnet_02"
          cidr_block              = "10.0.3.0/24"
          availability_zone       = "us-west-1c"
          map_public_ip_on_launch = false
          route_table_key         = "private_rt"
        }
      }
      nat_subnet_key    = "public_subnet_01"
      connectivity_type = "public"
      map_rt_objects = {
        public_rt = {
          name       = "public_route_table"
          cidr_block = "0.0.0.0/0"
          is_public  = true
        }

        private_rt = {
          name       = "private_route_table"
          cidr_block = "0.0.0.0/0"
          is_public  = false
        }
      }
    }
  }
  security_groups = {
    "sg-1" = {
      map_sg_objects = {
        common_sg = {
          name = "allow_all_sg"
          ingress = {
            allow_http = {
              from_port   = 0
              to_port     = 65535
              protocol    = "tcp"
              cidr_blocks = ["0.0.0.0/0"]
            }
          }
          egress = {
            allow_all = {
              from_port   = 0
              to_port     = 0
              protocol    = "-1"
              cidr_blocks = ["0.0.0.0/0"]
            }
          }
        }
      }
    }
  }
}
user_defined_tags = {
  "Layer"       = 1
  "Description" = "Provisioning infra for networking"
}
