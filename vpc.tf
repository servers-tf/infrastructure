resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    
    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags = {
        Name = "main"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "ig"
    }
}
