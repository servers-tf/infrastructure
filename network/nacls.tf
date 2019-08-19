resource "aws_network_acl" "sandbox" {
    vpc_id = "${aws_vpc.main.id}"
    subnet_ids = ["${aws_subnet.sandbox.id}"]

    ingress {
        protocol = "tcp"
        rule_no = 101
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
        from_port = 0
        to_port = 65535
    }
}


resource "aws_network_acl" "web" {
    vpc_id = "${aws_vpc.main.id}"
    subnet_ids = ["${aws_subnet.web.id}"]

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
        from_port = 0
        to_port = 65535
    }
}


resource "aws_network_acl" "gameserver" {
    vpc_id = "${aws_vpc.main.id}"
    subnet_ids = ["${aws_subnet.gameserver.id}"]

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
        rule_no = 200
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 27015
        to_port = 27015
    }
    ingress {
        protocol = "tcp"
        rule_no = 201
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 27020
        to_port = 27020
    }
    ingress {
        protocol = "udp"
        rule_no = 202
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 27015
        to_port = 27015
    }
    ingress {
        protocol = "udp"
        rule_no = 203
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 27020
        to_port = 27020
    }
    
    ingress {
        protocol = "tcp"
        rule_no = 998
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 32768
        to_port = 65535
    }
    ingress {
        protocol = "udp"
        rule_no = 999
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 32768
        to_port = 65535
    }
    
    egress {
        protocol = "tcp"
        rule_no = 998
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 65535
    }
    egress {
        protocol = "udp"
        rule_no = 999
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 65535
    }
}
