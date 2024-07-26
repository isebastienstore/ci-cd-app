variable "eks_cluster_name" {
    default  =  "demo-eks"
}

variable "subnet_ids" {
    description = "List of subnet IDs"
    default     = [
        "subnet-0f3a88a9451064c46",
        "subnet-0d4b93e294e2413fa",
        "subnet-09768f4f7d2a6bdb3",
        "subnet-06701f13c28027546"
    ]
}


variable "tags" {
    description = "Tags for the node group"
    type        = map(string)
}

