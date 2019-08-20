resource "aws_route53_record" "internal" {
    zone_id = "${var.internal_dns_zone_id}"
    name = "${var.elasticsearch_name}"
    type = "CNAME"
    ttl = "300"

    records = ["${aws_elasticsearch_domain.es.endpoint}"]
}
