resource "aws_route_table" "private" {
  vpc_id = aws_vpc.current.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.current.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.env}-private-route-table"
    Type = "Private Route Table"
  })
}


resource "aws_route_table_association" "private" {
  count = length(var.private_subnets.cidr_blocks)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.current.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.current.id
  }

  tags = merge(local.common_tags,
    {
      Name = "${var.env}-public-route-table"
      Type = "Public Route Table"
    }
  )
}


resource "aws_route_table_association" "public" {
  count = length(var.public_subnets.cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


