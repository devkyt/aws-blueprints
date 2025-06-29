resource "aws_security_group" "nlb" {
  name        = "${local.private_link_name}-nlb-sg"
  description = "Traffic to the network load balancer within the provider VPC"

  vpc_id = var.aws_provider.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = local.port
    to_port     = local.port
    cidr_blocks = var.network_load_balancer.allow_cidr_blocks
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${local.private_link_name}-nlb-sg"
    Type = "Security Group"
  })
}


resource "aws_security_group" "alb" {
  name        = "${local.private_link_name}-alb-sg"
  description = "Traffic to the application load balancer within the provider VPC"

  vpc_id = var.aws_provider.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = local.port
    to_port         = local.port
    security_groups = [aws_security_group.nlb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${local.private_link_name}-alb-sg"
    Type = "Security Group"
  })
}


resource "aws_security_group" "private_link_endpoint" {
  name        = "${local.private_link_name}-endpoint-sg"
  description = "Traffic to the private link endpoint within the consumer VPC"

  vpc_id = var.aws_consumer.vpc_id

  ingress {
    from_port   = local.port
    to_port     = local.port
    protocol    = "tcp"
    cidr_blocks = [var.aws_consumer.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags,
    {
      Name = "${local.private_link_name}-endpoint-sg"
      Type = "Security Group"
    }
  )
}
