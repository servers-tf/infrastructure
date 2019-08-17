resource "aws_network_acl" "sandbox" {
    vpc_id = "${aws_vpc.main.id}"
    subnet_ids = ["${aws_subnet.sandbox.id}"]

    ingress {
        protocol = "-1"
        rule_no = 100
        action = "deny"
        cidr_block = "0.0.0.0/0"
        icmp_code = -1
        icmp_type = -1
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "tcp"
        rule_no = 22
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 65535
    }
    ingress {
        protocol = "tcp"
        rule_no = 999
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 32768
        to_port = 65535
    }
    egress {
        protocol = "tcp"
        rule_no = 999
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 32768
        to_port = 65535
    }
}


resource "aws_network_acl" "web" {
    vpc_id = "${aws_vpc.main.id}"
    subnet_ids = ["${aws_subnet.web.id}"]

    ingress {
        protocol = "-1"
        rule_no = 100
        action = "deny"
        cidr_block = "0.0.0.0/0"
        icmp_code = -1
        icmp_type = -1
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "tcp"
        rule_no = 101
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 22
        to_port = 22
    }
    ingress {
        protocol = "tcp"
        rule_no = 102
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 80
        to_port = 80
    }
    ingress {
        protocol = "tcp"
        rule_no = 103
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }
    ingress {
        protocol = "tcp"
        rule_no = 999
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 32768
        to_port = 65535
    }
    egress {
        protocol = "tcp"
        rule_no = 999
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 32768
        to_port = 65535
    }
}


resource "aws_network_acl" "gameserver" {
    vpc_id = "${aws_vpc.main.id}"
    subnet_ids = ["${aws_subnet.gameserver.id}"]

    ingress {
        protocol = "-1"
        rule_no = 100
        action = "deny"
        cidr_block = "0.0.0.0/0"
        icmp_code = -1
        icmp_type = -1
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "tcp"
        rule_no = 101
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 22
        to_port = 22
    }
    ingress {
        protocol = "tcp"
        rule_no = 999
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 32768
        to_port = 65535
    }
    egress {
        protocol = "tcp"
        rule_no = 999
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 32768
        to_port = 65535
    }
}
