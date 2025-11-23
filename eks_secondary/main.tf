module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "21.9.0"

  name            = "vault-secondary-eks"
  kubernetes_version         = "1.29"

  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets

  eks_managed_node_groups = {
    vault_nodes = {
      desired_size = 3
      max_size     = 6
      min_size     = 3
      instance_types = ["m5.large"]
      capacity_type = "ON_DEMAND"
    }
  }
}

resource "aws_security_group_rule" "allow_replication" {
  type              = "ingress"
  from_port         = 8200
  to_port           = 8200
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_primary_cidr]
  security_group_id = module.eks.cluster_security_group_id
}



