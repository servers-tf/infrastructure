resource "aws_route53_record" "grafana" {
    zone_id = "${var.external_dns_zone_id}"
    name = "grafana"
    type = "CNAME"
    ttl = "300"

    records = ["${aws_instance.grafana.public_dns}"]
}

resource "aws_route53_record" "kibana" {
    zone_id = "${var.external_dns_zone_id}"
    name = "kibana"
    type = "CNAME"
    ttl = "300"

    records = ["${aws_instance.grafana.public_dns}"]
}
