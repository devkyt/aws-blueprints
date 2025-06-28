resource "aws_lb_target_group" "current" {
  count = var.target_group.create ? 1 : 0

  target_type = "ip"
  vpc_id      = var.vpc_id

  name     = "${local.name}-${var.target_group.name}"
  protocol = "HTTP"
  port     = var.target_group.port

  health_check {
    protocol            = "HTTP"
    path                = var.target_group.health_check.path
    interval            = var.target_group.health_check.interval
    timeout             = var.target_group.health_check.timeout
    healthy_threshold   = var.target_group.health_check.healthy_threshold
    unhealthy_threshold = var.target_group.health_check.unhealthy_threshold
    matcher             = "200-399"
  }

  tags = merge(local.tags, {
    Name = "${local.name}-${var.target_group.name}"
    Type = "Target Group (IP)"
  })
}

data "aws_lb_target_group" "current" {
  arn = coalesce(aws_lb_target_group.current[0].arn, var.target_group.arn)
}
