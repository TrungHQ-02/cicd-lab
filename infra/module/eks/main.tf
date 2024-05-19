resource "aws_eks_cluster" "this" {
  name     = var.cluster.cluster_name
  role_arn = data.aws_iam_role.admin[0].arn

  vpc_config {
    subnet_ids = [data.aws_subnet.private_subnet0[0].id, data.aws_subnet.private_subnet1[0].id]
    # security_group_ids = [data.aws_security_groups.security_group.id]
    security_group_ids = data.aws_security_groups.security_group[0].ids
  }
  tags = merge(var.tags, {
    Name = var.cluster.cluster_name
  })
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.aws_eks_node_group.node_group_name
  node_role_arn   = data.aws_iam_role.eks-node-group[0].arn
  subnet_ids      = [data.aws_subnet.private_subnet0[0].id, data.aws_subnet.private_subnet1[0].id]
  instance_types  = var.aws_eks_node_group.instance_types
  capacity_type   = var.aws_eks_node_group.capacity_type
  scaling_config {
    desired_size = var.aws_eks_node_group.node_count
    min_size     = var.aws_eks_node_group.node_count
    max_size     = var.aws_eks_node_group.node_count
  }
  tags = merge(var.tags, {
    Name = var.cluster.cluster_name
  })
}

resource "aws_eks_addon" "this" {
  for_each      = var.aws_eks_addon
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = each.value.addon_name
  addon_version = each.value.addon_version
}







# resource "aws_eks_cluster" "this" {
#   name     = var.cluster.cluster_name
#   role_arn = aws_iam_role.example.arn
#   vpc_config {
#     subnet_ids         = var.cluster.vpc_config.subnet_ids
#     security_group_ids = var.cluster.vpc_config.security_group_ids
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
#   ]
#   tags = merge(var.tags, {
#     Name = var.cluster.cluster_name
#   })
# }

# resource "aws_eks_node_group" "this" {
#   cluster_name    = aws_eks_cluster.this.name
#   node_group_name = var.aws_eks_node_group.node_group_name
#   node_role_arn   = aws_iam_role.eks_node_group_role.arn
#   subnet_ids      = var.cluster.subnet_ids
#   instance_types  = var.aws_eks_node_group.instance_types
#   scaling_config {
#     desired_size = var.aws_eks_node_group.node_count
#     min_size     = var.aws_eks_node_group.node_count
#     max_size     = var.aws_eks_node_group.node_count
#   }
#   tags = merge(var.tags, {
#     Name = var.cluster.cluster_name
#   })

#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#   ]
# }

# resource "aws_iam_role" "eks-cluster-example" {
#   name               = "eks-cluster-example"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.example.name
# }

# # Optionally, enable Security Groups for Pods
# # Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
# resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role       = aws_iam_role.example.name
# }


# resource "aws_iam_role" "example" {
#   name = "eks-node-group-example"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }
# resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.example.name
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.example.name
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.example.name
# }



# resource "aws_eks_cluster" "this" {
#   name     = var.cluster.cluster_name
#   role_arn = var.cluster.role_arn


#   vpc_config {
#     subnet_ids         = var.cluster.subnet_ids
#     security_group_ids = var.cluster.security_group_ids
#   }

#   # dynamic "vpc_config" {
#   #   content {
#   #     subnet_ids = var
#   #     security_group_ids =
#   #   }
#   # }
#   # # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#   # # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#   # depends_on = [
#   #   aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
#   #   aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
#   # ]
# }
# resource "aws_iam_role" "example" {
#   name               = "eks-cluster-example"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.example.name
# }

# # Optionally, enable Security Groups for Pods
# # Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
# resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role       = aws_iam_role.example.name
# }







# ---------------------------------------------------------------------------------------
#     SOURCE CODE -----------------------------------------------------------------------
# resource "aws_eks_cluster" "this" {
#   name     = var.cluster.cluster_name
#   role_arn = role_arn = var.cluster.role_arn
#   vpc_config {
#     subnet_ids         = var.cluster.subnet_ids
#     security_group_ids = var.cluster.security_group_ids
#   }
#   tags = merge(var.tags, {
#     Name = var.cluster.cluster_name
#   })
# }

# resource "aws_eks_node_group" "this" {
#   cluster_name    = aws_eks_cluster.this.name
#   node_group_name = var.aws_eks_node_group.node_group_name
#   node_role_arn   = var.aws_eks_node_group.node_role_arn
#   subnet_ids      = var.cluster.subnet_ids
#   instance_types  = var.aws_eks_node_group.instance_types
#   scaling_config {
#     desired_size = var.aws_eks_node_group.node_count
#     min_size     = var.aws_eks_node_group.node_count
#     max_size     = var.aws_eks_node_group.node_count
#   }
#   tags = merge(var.tags, {
#     Name = var.cluster.cluster_name
#   })
# }
