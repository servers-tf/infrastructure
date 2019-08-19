# data "aws_ami" "tf2_competitive" {
#     executable_users = ["self"]
#     most_recent = true
#     owners = ["self"]
#
#     filter {
#         name   = "tag:Family"
#         values = ["tf2-competitive"]
#     }
#
#     filter {
#         name   = "state"
#         values = ["available"]
#     }
#
# }

resource "aws_launch_template" "tf2_competitive" {
    name = "tf2-competitive"

    # Provisioning
    instance_type = "${var.gameserver_instance_size}"
    key_name = "${var.ssh_keyname}"
    user_data = "${base64encode(<<EOF
		#! /bin/bash
        /bin/bash /opt/startup.sh
	EOF
    )}"
    
    instance_market_options {
        market_type = "spot"
        spot_options {
            block_duration_minutes = "360"
            spot_instance_type = "one-time"
            instance_interruption_behavior = "terminate"
        }
    }

    # Network
    network_interfaces {
        associate_public_ip_address = true
        delete_on_termination = true
        subnet_id = "${var.gameserver_subnet_id}"
        security_groups = [
            "${var.ssh_securitygroup_id}",
            "${aws_security_group.tf2_srcds.id}"
        ]
    }

    # Disk
    ebs_optimized = true
    block_device_mappings {
        device_name = "/dev/sda1"
        ebs {
            volume_size = 20
            delete_on_termination = true
        }
    }
    
    # Permissions
    iam_instance_profile {
        name = "${aws_iam_instance_profile.tf2_competitive.name}"
    }

    # Other
    monitoring {
        enabled = false
    }
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "terminate"
}
