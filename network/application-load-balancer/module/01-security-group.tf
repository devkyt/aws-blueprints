resource "aws_security_group" "current" {
  name        = "${local.name}-sg"
  description = "Security group to control access to the application load balancer"
  vpc_id      = var.vpc_id

  ingress {
    protocol         = "TCP"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.tags,
    {
      Name = "${local.name}-sg"
      Type = "Security Group"
    }
  )
}
