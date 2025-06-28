resource "aws_vpc_endpoint_service" "private_link_service" {
  network_load_balancer_arns = [aws_lb.nlb.arn]
  acceptance_required        = false

  private_dns_name = true

  tags = merge(local.tags, {
    Name = "${local.private_link_name}-service"
    Type = "Private Link Service"
  })
}


resource "aws_vpc_endpoint" "private_link_endpoint" {
  vpc_endpoint_type = "Interface"
  vpc_id            = var.aws_consumer.vpc_id
  subnet_ids        = var.aws_consumer.subnets_ids

  service_name       = aws_vpc_endpoint_service.private_link_service.service_name
  security_group_ids = [aws_security_group.private_link_endpoint.id]

  tags = merge(local.tags, {
    Name = "${local.private_link_name}-endpoint"
    Type = "Private Link Endpoint"
  })
}
