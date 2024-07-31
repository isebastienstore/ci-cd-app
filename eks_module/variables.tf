variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "access_key" {
    default = ""
}
variable "secret_key" {
    default = ""
}


variable "region" {
    default = "us-east-1"
}
