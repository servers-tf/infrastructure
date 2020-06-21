data "aws_caller_identity" "current" {}
data "aws_ami" "database" {
    most_recent = true

    filter {
        name   = "name"
        values = ["database-*"]
    }

    owners = ["${data.aws_caller_identity.current.account_id}"]
}

resource "aws_instance" "database" {
    # Provisioning
    ami = "${data.aws_ami.database.id}"
    instance_type = "${var.database_instance_size}"
    key_name = "${var.ssh_keyname}"

    # Network
    associate_public_ip_address = true
    subnet_id = "${var.database_subnet_id}"
    vpc_security_group_ids = [
        "${var.ssh_securitygroup_id}",
        "${aws_security_group.mysql.id}",
        "${aws_security_group.mongo.id}"
    ]
    
    # Permissions
    iam_instance_profile = "${aws_iam_instance_profile.database.name}"

    # Other
    monitoring = false
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "terminate"
    
    tags = {
        Name = "database"
    }
}
