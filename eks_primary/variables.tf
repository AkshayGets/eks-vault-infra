variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster is deployed"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for EKS worker nodes"
  type        = list(string)
}

variable "vpc_secondary_cidr" {
  description = "CIDR block of the secondary VPC (for SG rules)"
  type        = string
}
