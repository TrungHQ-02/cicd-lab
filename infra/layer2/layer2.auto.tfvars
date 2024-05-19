resource_configs = {
  ec2 = {
    list_s3_role_instance = {
      ####################
      ami           = "ami-080e1f13689e07408"
      instance_type = "t2.medium"
      instance_name = "Lab01-instance"
      user_data     = <<-EOF
                #!/bin/bash

                sudo apt update -y  

                # install aws cli
                sudo apt install unzip -y
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install
                EOF

      subnet_name = "public_subnet_01"



      ############# 
      has_key_pair  = false
      key_pair_name = "ssh-key"
      key_pair_path = "~/.ssh/ssh-ec2.pub"

      ##############
      sg_name = "allow_all_sg"

      ##############
      enable_role = true
      role_name   = "aws-trunghq13-lab-allow-ec2-assume-role"
      ##############

      has_ebs         = false
      ebs_volume_size = 4
      ebs_device_name = "/dev/sdf"
    }
  }


  role = {
    instance_role = {
      map_policy_objects = {
        eks-cluster-policy = {
          name        = "role-for-ec2-instance-profile"
          description = "IAM Policy to allow ec2 to have necessary action"
          policy = {
            "Version" : "2012-10-17",
            "Statement" : [
              {
                "Effect" : "Allow",
                "Action" : "*",
                "Resource" : "*"
              }
            ]
          }
        }
      }
      role_object = {
        name = "allow-ec2-assume-role"
        assume_role_policy = {
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Principal" : {
                "Service" : "ec2.amazonaws.com"
              },
              "Action" : "sts:AssumeRole"
            }
          ]
        }
      }

    }
  }



}
