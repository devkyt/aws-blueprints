resource "aws_internet_gateway" "current" {
  vpc_id = aws_vpc.current.id

  tags = merge(local.common_tags,
    {
      Name = "${var.env}-internet-gateway"
      Type = "Internet Gateway"
    }
  )
}
