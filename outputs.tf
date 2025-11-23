output "primary_vpc_id" {
  value = module.vpc_primary.vpc_id
}

output "secondary_vpc_id" {
  value = module.vpc_secondary.vpc_id
}

output "primary_eks_cluster_name" {
  value = module.eks_primary.cluster_name
}

output "secondary_eks_cluster_name" {
  value = module.eks_secondary.cluster_name
}
