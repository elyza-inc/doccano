resource "aws_route53_record" "doccano" {
  zone_id = var.route53_zone_id
  name    = "doccano"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.doccano.private_ip]
}
