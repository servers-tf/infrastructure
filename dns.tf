resource "aws_route53_zone" "private" {
    name = "stf.internal"

    vpc {
        vpc_id = "${aws_vpc.main.id}"
    }
}

resource "aws_vpc_dhcp_options" "domains" {
    domain_name = "stf.internal"
    domain_name_servers = ["10.0.0.2", "8.8.8.8"]
}

resource "aws_vpc_dhcp_options_association" "domains" {
  vpc_id = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.domains.id}"
}
