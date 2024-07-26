aws_eks_cluster_config = {
    "demo-cluster" = {
        eks_cluster_name = "demo-cluster1"
        eks_subnet_ids   = ["subnet-0f3a88a9451064c46","subnet-09768f4f7d2a6bdb3"]
        tags             = {
            "Name" = "demo-cluster"
        }
    }
}


eks_node_group_config = {
    "node1" = {
        eks_cluster_name = "demo-cluster"
        node_group_name  = "mynode"
        nodes_iam_role   = "eks-node-group-general1"
        node_subnet_ids  = ["subnet-0f3a88a9451064c46","subnet-09768f4f7d2a6bdb3"]
        instance_type    = "t2.medium"
        desired_capacity = 1
        max_size         = 3
        min_size         = 1
        tags             = {
            "Name" = "node1"
        }
    }
}
