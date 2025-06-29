resource "aws_lb" "alb" {
  load_balancer_type = "application"
  internal           = true

  name              = local.alb_name
  subnets           = var.aws_provider.subnets_ids
  security_groups   = [aws_security_group.alb.id]
  client_keep_alive = var.application_load_balancer.keep_alive

  tags = merge(local.tags, {
    Name = local.alb_name
    Type = "Application Load Balancer"
  })
}


resource "aws_lb_target_group" "alb_target" {
  target_type = "ip"
  vpc_id      = var.aws_provider.vpc_id

  name     = "${local.alb_name}-target"
  protocol = "HTTP"
  port     = var.application_load_balancer.target_group.port

  health_check {
    protocol            = "HTTP"
    path                = var.application_load_balancer.target_group.health_check.path
    interval            = var.application_load_balancer.target_group.health_check.interval
    timeout             = var.application_load_balancer.target_group.health_check.timeout
    healthy_threshold   = var.application_load_balancer.target_group.health_check.healthy_threshold
    unhealthy_threshold = var.application_load_balancer.target_group.health_check.unhealthy_threshold
    matcher             = "200-399"
  }

  tags = merge(local.tags, {
    Name = "${local.alb_name}-target"
    Type = "Target Group (IP)"
  })
}


resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTPS"
  port              = local.port
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }

  tags = merge(local.tags,
    {
      Name     = "${local.alb_name}-listener"
      Protocol = "HTTPS"
    }
  )
}
