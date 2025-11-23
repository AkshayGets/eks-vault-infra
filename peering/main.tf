resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.primary_vpc_id
  peer_vpc_id   = var.secondary_vpc_id
  auto_accept   = true

  tags = {
    Name = "vault-primary-to-secondary"
  }
}

resource "aws_route" "primary_to_secondary" {
  route_table_id         = aws_route_table.primary_rt.id
  destination_cidr_block = var.secondary_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "secondary_to_primary" {
  route_table_id         = aws_route_table.secondary_rt.id
  destination_cidr_block = var.primary_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
