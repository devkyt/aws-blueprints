
resource "aws_route53_record" "txt" {
  name    = var.domain
  records = [aws_vpc_endpoint_service.private_link_service.private_dns_name_configuration[0]["value"]]
  type    = "TXT"
  ttl     = "1800"
  zone_id = data.aws_route53_zone.domain.zone_id

  depends_on = [aws_vpc_endpoint_service.private_link_service]
}

resource "aws_route53_record" "cname" {
  for_each = toset(var.subdomains)

  name    = "${each.key}.${var.domain}"
  records = [aws_vpc_endpoint.private_link_endpoint.dns_entry[0].dns_name]
  type    = "CNAME"
  ttl     = "1800"
  zone_id = data.aws_route53_zone.domain.zone_id

  depends_on = [aws_vpc_endpoint_service.private_link_service]
}
