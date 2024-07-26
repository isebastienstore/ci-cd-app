

# Ressource pour le cluster EKS
resource "aws_eks_cluster" "eks" {
    name     = var.eks_cluster_name
    role_arn = aws_iam_role.eks_cluster.arn
    version  = "1.24"

    vpc_config {
        endpoint_private_access = false
        endpoint_public_access  = true
        subnet_ids              = var.subnet_ids
    }

    depends_on = [
        aws_iam_role_policy_attachment.amazon_eks_cluster_policy
    ]
    tags = {
        "Name" =  "demo-cluster"
    }
}

# Ressource pour le rôle IAM du cluster EKS
resource "aws_iam_role" "eks_cluster" {
    name = "eks-cluster"

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attachement de la politique IAM au rôle du cluster EKS
resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role     = aws_iam_role.eks_cluster.name
}

# Attachement de la politique IAM pour le registre de conteneurs
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role     = aws_iam_role.eks_cluster.name
}

# Ressource pour le groupe de nœuds EKS
resource "aws_eks_node_group" "nodes_general" {
    cluster_name    = var.eks_cluster_name
    node_group_name = var.node_group_name
    node_role_arn   = aws_iam_role.nodes_general.arn
    subnet_ids      = var.subnet_ids

    scaling_config {
        desired_size = var.desired_capacity
        max_size     = var.max_size
        min_size     = var.min_size
    }

    ami_type       = "AL2_x86_64"
    capacity_type  = "ON_DEMAND"
    disk_size      = 20
    force_update_version = false
    instance_types = ["t2.medium"]
    version        = "1.24"

    depends_on = [
        aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
        aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
        aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
    ]
    tags = {
        "Name" =  "node1"
    }
}

# Ressource pour le rôle IAM des nœuds EKS
resource "aws_iam_role" "nodes_general" {
    name = var.node_group_name

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attachement de la politique IAM pour le groupe de nœuds EKS
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role     = aws_iam_role.nodes_general.name
}

# Attachement de la politique IAM pour le CNI d'EKS
resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role     = aws_iam_role.nodes_general.name
}

# Attachement de la politique IAM pour le registre de conteneurs
resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role     = aws_iam_role.nodes_general.name
}

variable "eks_cluster_name" {
    description = "Name of the EKS cluster"
    type        = string
    default     = "demo-eks"
}

variable "subnet_ids" {
    description = "List of subnet IDs"
    type        = list(string)
    default     = [
        "subnet-0f3a88a9451064c46",
        "subnet-0d4b93e294e2413fa",
        "subnet-09768f4f7d2a6bdb3",
        "subnet-06701f13c28027546"
    ]
}

variable "tags" {
    description = "Tags for the resources"
    type        = map(string)
    default = {}
}

variable "node_group_name" {
    description = "Name of the node group"
    type        = string
    default     = "nodes-general"
}

variable "desired_capacity" {
    description = "Desired number of worker nodes"
    type        = number
    default     = 1
}

variable "max_size" {
    description = "Maximum number of worker nodes"
    type        = number
    default     = 1
}

variable "min_size" {
    description = "Minimum number of worker nodes"
    type        = number
    default     = 1
}

variable "nodes_iam_role" {
    description = "IAM role for the node group"
    type        = string
    default     = "eks-node-group-general"
}
