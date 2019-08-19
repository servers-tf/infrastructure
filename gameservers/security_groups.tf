resource "aws_security_group" "tf2_srcds" {
    name = "Team Fortress 2"
    description = "Allow SRCDS connections"
    vpc_id = "${var.vpc_id}"
    
    ingress {
        from_port = 27015
        to_port = 27015
        protocol = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    ingress {
        from_port = 27015
        to_port = 27015
        protocol = "udp"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    ingress {
        from_port = 27020
        to_port = 27020
        protocol = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    ingress {
        from_port = 27020
        to_port = 27020
        protocol = "udp"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "Team Fortress 2"
    }
}
