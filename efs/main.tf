resource "aws_efs_file_system" "this" {
    tags = {
        Name = "TF2 Competitive"
    }
}

resource "aws_efs_mount_target" "this" {
    count = length(var.subnet_ids)
    file_system_id = aws_efs_file_system.this.id
    subnet_id = var.subnet_ids[count.index]
    security_groups = [
        aws_security_group.this.id
    ]
}

resource "aws_security_group" "this" {
    name = "TF2 Competitive - EFS"
    description = "Allows connection to EFS"
    vpc_id = var.vpc_id
    
    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        self = true
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        self = true
    }
    
    tags = {
        Name = "EFS"
    }
}
