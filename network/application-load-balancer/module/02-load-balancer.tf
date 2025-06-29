resource "aws_lb" "current" {
  load_balancer_type = "application"
  internal           = false

  name            = local.name
  security_groups = [aws_security_group.current.id]
  subnets         = var.subnets_ids

  tags = merge(local.tags,
    {
      Name = local.name
      Type = "Application Load Balancer"
    }
  )
}
