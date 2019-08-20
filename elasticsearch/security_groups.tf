resource "aws_security_group" "es" {
    name = "elasticsearch-gameservers"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 443
        to_port   = 443
        protocol  = "tcp"

        cidr_blocks = [
            "10.0.0.0/16",
            "99.31.76.144/32"
        ]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "Elastic Search"
    }
}
