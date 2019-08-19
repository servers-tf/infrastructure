resource "aws_security_group" "home_ssh" {
    name = "Home SSH"
    description = "SSH from home"
    vpc_id = "${aws_vpc.main.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =  "${var.ssh_ip_addrs}"
        self = true
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "Home SSH"
    }
}

resource "aws_security_group" "packer_ssh" {
    name = "Packer SSH"
    description = "SSH for Packer"
    vpc_id = "${aws_vpc.main.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        self = true
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "Packer SSH"
    }
}
