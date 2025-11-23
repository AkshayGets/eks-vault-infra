terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc_primary" {
  source = "./vpc_primary"
  region = var.region
}

module "vpc_secondary" {
  source = "./vpc_secondary"
  region = var.region
}

module "vpc_peering" {
  source = "./peering"

  primary_vpc_id   = module.vpc_primary.vpc_id
  secondary_vpc_id = module.vpc_secondary.vpc_id

  primary_cidr   = module.vpc_primary.vpc_cidr
  secondary_cidr = module.vpc_secondary.vpc_cidr
}

module "eks_primary" {
  source = "./eks_primary"

  region                = var.region
  vpc_id                = module.vpc_primary.vpc_id
  private_subnets       = module.vpc_primary.private_subnets
  vpc_secondary_cidr    = module.vpc_secondary.vpc_cidr
}

module "eks_secondary" {
  source = "./eks_secondary"

  region                = var.region
  vpc_id                = module.vpc_secondary.vpc_id
  private_subnets       = module.vpc_secondary.private_subnets
  vpc_primary_cidr      = module.vpc_primary.vpc_cidr
}

