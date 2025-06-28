resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.current.arn
  protocol          = "HTTPS"
  port              = 443
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  dynamic "default_action" {
    for_each = var.auth0[*]
    iterator = auth0

    content {
      type = "authenticate-oidc"

      authenticate_oidc {
        client_id              = auth0.value.client_id
        client_secret          = auth0.value.client_secret
        authorization_endpoint = "https://${auth0.value.domain}/authorize"
        issuer                 = "https://${auth0.value.domain}/"
        token_endpoint         = "https://${auth0.value.domain}/oauth/token"
        user_info_endpoint     = "https://${auth0.value.domain}/userinfo"
      }
    }
  }

  default_action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.current.arn
  }

  tags = merge(local.tags, {
    Name     = "${local.name}-https-listener"
    Protocol = "HTTPS"
  })
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.current.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = merge(local.tags, {
    Name     = "${local.name}-http-listener"
    Protocol = "HTTP"
  })
}
