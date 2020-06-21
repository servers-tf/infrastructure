resource "aws_route53_record" "mysql" {
    zone_id = "${var.internal_dns_zone_id}"
    name = "mysql"
    type = "CNAME"
    ttl = "300"

    records = ["${aws_instance.database.private_dns}"]
}

resource "aws_route53_record" "mongo" {
    zone_id = "${var.internal_dns_zone_id}"
    name = "mongo"
    type = "CNAME"
    ttl = "300"

    records = ["${aws_instance.database.private_dns}"]
}
