resource "aws_vpc" "this" {
  cidr_block = "10.10.0.0/16"
  tags = { Name = "vault-primary-vpc" }
}

resource "aws_subnet" "private" {
  count = 3
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = "${var.region}${substr("abc", count.index, 1)}"

  tags = { Name = "vault-primary-private-${count.index}" }
}

# Create a private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "vault-primary-private-rt" }
}

# Associate private subnets with the route table
resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}


