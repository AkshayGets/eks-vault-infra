variable "primary_vpc_id" {
  description = "VPC ID of the primary Vault VPC"
  type        = string
}

variable "secondary_vpc_id" {
  description = "VPC ID of the secondary Vault VPC"
  type        = string
}

variable "primary_cidr" {
  description = "Primary VPC CIDR"
  type        = string
}

variable "secondary_cidr" {
  description = "Secondary VPC CIDR"
  type        = string
}
