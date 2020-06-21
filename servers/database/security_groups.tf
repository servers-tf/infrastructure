resource "aws_security_group" "mysql" {
    name = "database_mysql"
    description = "Allows mysql"
    vpc_id = "${var.vpc_id}"
    
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        self = true
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "Database - MySQL"
    }
}

resource "aws_security_group" "mongo" {
    name = "database_mongo"
    description = "Allows mongodb"
    vpc_id = "${var.vpc_id}"
    
    ingress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        self = true
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "Database - Mongo"
    }
}
