locals {
  private_link_name = "${var.env}-${var.name}-private-link"

  port = 443

  alb_name = "${var.env}-${var.application_load_balancer.name}-alb"
  nlb_name = "${var.env}-${var.network_load_balancer.name}-nlb"

  tags = merge(var.tags, {
    Env       = var.env
    PartOf    = "private-link"
    Terraform = "true"
    }
  )
}
