output "primary_vpc_id" {
  value = module.vpc_primary.vpc_id
}

output "secondary_vpc_id" {
  value = module.vpc_secondary.vpc_id
}
