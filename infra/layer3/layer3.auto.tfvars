

resource_configs = {
  eks_configs = {
    cluster = {
      cluster_name = "trunghq-cluster"
      role_arn     = "eks-cluster"
      vpc_config = {
        subnet_ids         = ["private_subnet_01", "private_subnet_02"]
        security_group_ids = ["allow_all_sg"]
      }
    }
    aws_eks_node_group = {
      node_group_name = "trunghq-cluster-worker"
      node_role_arn   = "eks-node-group"
      node_count      = 3
      capacity_type   = "SPOT"
      instance_types  = ["t2.medium"]
    }
    aws_eks_addon = {
      coredns = {
        addon_name    = "coredns"
        addon_version = "v1.11.1-eksbuild.4"
      }
      kube-proxy = {
        addon_name    = "kube-proxy"
        addon_version = "v1.29.0-eksbuild.1"
      }
      vpc-cni = {
        addon_name    = "vpc-cni"
        addon_version = "v1.16.0-eksbuild.1"
      }
      aws-ebs-csi-driver = {
        addon_name    = "aws-ebs-csi-driver"
        addon_version = "v1.30.0-eksbuild.1"
      }
      eks-pod-identity-agent = {
        addon_name    = "eks-pod-identity-agent"
        addon_version = "v1.2.0-eksbuild.1"
      }
    }
  }
  role = {
    eks-cluster = {
      role_object = {
        name = "eks-cluster"
        assume_role_policy = {
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Principal" : {
                "Service" : "eks.amazonaws.com"
              },
              "Action" : "sts:AssumeRole"
            }
          ]
        }
      }
      map_policy_objects = {
        eks-cluster-policy = {
          name        = "eks-cluster-policy-eks"
          description = "IAM Policy to allow EKS cluster to have necessary action"
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
    }
    eks-node-group = {
      role_object = {
        name = "eks-node-group"
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
      map_policy_objects = {
        eks-node-group-policy = {
          name        = "eks-node-group-policy"
          description = "IAM Policy to allow EKS Node Group to have necessary action"
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

    }
  }
}

user_defined_tags = {
  "Layer"       = 3
  "Description" = "Provisionin eks cluster"
}
