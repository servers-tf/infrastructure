# Reserved for use by NAT's and other appliances
resource "aws_subnet" "reserved" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.reserved_subnet_cidr}"
    map_public_ip_on_launch  = false

    tags = {
        Name = "reserved"
    }
}
resource "aws_route_table" "reserved" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }
}
resource "aws_route_table_association" "reserved" {
    subnet_id = "${aws_subnet.reserved.id}"
    route_table_id = "${aws_route_table.reserved.id}"
}

# Used for builds or otherwise unimportant things
# Not able to access other subnets
resource "aws_subnet" "sandbox" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sandbox_subnet_cidr}"
    map_public_ip_on_launch = true

    tags = {
        Name = "sandbox"
    }
}
resource "aws_route_table" "sandbox" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }
}
resource "aws_route_table_association" "sandbox" {
    subnet_id = "${aws_subnet.sandbox.id}"
    route_table_id = "${aws_route_table.sandbox.id}"
}

# Used for web applications
# Bot software
# Frontends
resource "aws_subnet" "web" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.web_subnet_cidr}"
    map_public_ip_on_launch = true

    tags = {
        Name = "web"
    }
}
resource "aws_route_table" "web" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }
}
resource "aws_route_table_association" "web" {
    subnet_id = "${aws_subnet.web.id}"
    route_table_id = "${aws_route_table.web.id}"
}

# Used to back web and gameserver resources
# Not accessiable from the internet
resource "aws_subnet" "database" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.database_subnet_cidr}"
    map_public_ip_on_launch = false

    tags = {
        Name = "database"
    }
}
resource "aws_route_table" "database" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }
}
resource "aws_route_table_association" "database" {
    subnet_id = "${aws_subnet.database.id}"
    route_table_id = "${aws_route_table.database.id}"
}

# Used to house all the gameservers
resource "aws_subnet" "gameserver" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.gameserver_subnet_cidr}"
    map_public_ip_on_launch = true

    tags = {
        Name = "gameserver"
    }
}
resource "aws_route_table" "gameserver" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }
}
resource "aws_route_table_association" "gameserver" {
    subnet_id = "${aws_subnet.gameserver.id}"
    route_table_id = "${aws_route_table.gameserver.id}"
}
