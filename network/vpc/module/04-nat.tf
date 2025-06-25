resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(local.common_tags, { Name = "${var.env}-nat-eip" })
}


resource "aws_nat_gateway" "current" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(local.common_tags, { Name = "${var.env}-nat-gateway" })

  depends_on = [aws_internet_gateway.current]
}
