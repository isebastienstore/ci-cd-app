variable "access_key" {
    description = "AWS Access Key"
    type        = string
}

variable "secret_key" {
    description = "AWS Secret Key"
    type        = string
}

variable "region" {
    description = "AWS Region"
    type        = string
}


variable "aws_eks_cluster_config" {
    type = map(object({
        eks_cluster_name = string
        eks_subnet_ids   = list(string)
        tags             = map(string)
    }))
}

variable "eks_node_group_config" {
    type = map(object({
        node_group_name  = string
        node_subnet_ids  = list(string)
        nodes_iam_role   = string
        instance_type    = string
        desired_capacity = number
        max_size         = number
        min_size         = number
        tags             = map(string)
    }))
}

