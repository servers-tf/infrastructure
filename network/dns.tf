resource "aws_route53_zone" "private" {
    name = "${var.internal_domain}"

    vpc {
        vpc_id = "${aws_vpc.main.id}"
    }
}

resource "aws_vpc_dhcp_options" "domains" {
    domain_name = "${var.internal_domain}"
    domain_name_servers = "${var.dns_resolvers}"
}

resource "aws_vpc_dhcp_options_association" "domains" {
  vpc_id = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.domains.id}"
}
