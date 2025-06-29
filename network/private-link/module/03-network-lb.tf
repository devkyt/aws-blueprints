resource "aws_lb" "nlb" {
  load_balancer_type = "network"
  internal           = true

  name              = local.nlb_name
  subnets           = var.aws_provider.subnets_ids
  security_groups   = [aws_security_group.nlb.id]
  client_keep_alive = var.network_load_balancer.keep_alive

  tags = merge(local.tags,
    {
      Name = local.nlb_name
      Type = "Network Load Balancer"
    }
  )
}


resource "aws_lb_target_group" "nlb_target" {
  target_type = "alb"
  vpc_id      = var.aws_provider.vpc_id

  name     = "${local.nlb_name}-target"
  protocol = "TCP"
  port     = local.port

  health_check {
    protocol            = "HTTPS"
    path                = var.application_load_balancer.target_group.health_check.path
    interval            = var.application_load_balancer.target_group.health_check.interval
    timeout             = var.application_load_balancer.target_group.health_check.timeout
    healthy_threshold   = var.application_load_balancer.target_group.health_check.healthy_threshold
    unhealthy_threshold = var.application_load_balancer.target_group.health_check.unhealthy_threshold
    matcher             = "200-399"
  }

  tags = merge(local.tags, {
    Name = "${local.nlb_name}-target"
    Type = "Target Group (IP)"
  })
}


resource "aws_lb_target_group_attachment" "nlb_target_attachment" {
  target_group_arn = aws_lb_target_group.nlb_target.arn
  target_id        = aws_lb.alb.arn
  port             = local.port
}


resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  protocol          = "TCP"
  port              = local.port

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target.arn
  }

  tags = merge(local.tags,
    {
      Name     = "${local.nlb_name}-listener"
      Protocol = "TCP"
    }
  )
}
