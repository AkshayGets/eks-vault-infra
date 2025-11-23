resource "aws_vpc" "this" {
  cidr_block = "10.20.0.0/16"
  tags = { Name = "vault-secondary-vpc" }
}

resource "aws_subnet" "private" {
  count = 3
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = "${var.region}${substr("abc", count.index, 1)}"

  tags = { Name = "vault-secondary-private-${count.index}" }
}

output "vpc_id"      { value = aws_vpc.this.id }
output "vpc_cidr"    { value = aws_vpc.this.cidr_block }
output "private_subnets" { value = aws_subnet.private[*].id }
