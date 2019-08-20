data "aws_caller_identity" "current" {}
data "aws_ami" "grafana" {
    most_recent = true

    filter {
        name   = "name"
        values = ["grafana-*"]
    }

    owners = ["${data.aws_caller_identity.current.account_id}"]
}

resource "aws_instance" "grafana" {
    # Provisioning
    ami = "${data.aws_ami.grafana.id}"
    instance_type = "${var.grafana_instance_size}"
    key_name = "${var.ssh_keyname}"

    # Network
    associate_public_ip_address = true
    subnet_id = "${var.grafana_subnet_id}"
    vpc_security_group_ids = [
        "${var.ssh_securitygroup_id}",
        "${aws_security_group.grafana.id}"
    ]
    
    # Permissions
    iam_instance_profile = "${aws_iam_instance_profile.grafana.name}"

    # Other
    monitoring = false
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "terminate"
    
    tags = {
        Name = "grafana"
    }
}
