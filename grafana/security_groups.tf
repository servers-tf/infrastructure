resource "aws_security_group" "grafana" {
    name = "Grafana"
    description = "Allows Grafana"
    vpc_id = "${var.vpc_id}"
    
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks =  "${var.whitelist_ipaddrs}"
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "Grafana"
    }
}
