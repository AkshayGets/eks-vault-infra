resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.primary_vpc_id
  peer_vpc_id   = var.secondary_vpc_id
  auto_accept   = true

  tags = {
    Name = "vault-primary-to-secondary"
  }
}

resource "aws_route" "primary_to_secondary" {
  for_each = toset(var.primary_route_table_ids)
  route_table_id         = each.value
  destination_cidr_block = var.secondary_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "secondary_to_primary" {
  for_each = toset(var.secondary_route_table_ids)
  route_table_id         = each.value
  destination_cidr_block = var.primary_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}
