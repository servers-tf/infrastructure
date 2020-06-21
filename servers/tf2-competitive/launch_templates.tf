locals {
    userdata = <<EOF
#!/bin/bash -v
/usr/bin/python3.6 /opt/startup.py
EOF

    security_group_ids = concat(
        var.security_group_ids,
        [
            aws_security_group.tf2_srcds.id
        ]
    )
}

data "aws_ami" "tf2_competitive" {
    most_recent = true

    filter {
        name   = "name"
        values = ["tf2-competitive-*"]
    }

    owners = ["${data.aws_caller_identity.current.account_id}"]
}

resource "aws_launch_template" "tf2_competitive" {
    name = "tf2-competitive"

    # Provisioning
    image_id = data.aws_ami.tf2_competitive.id
    instance_type = var.instance_size
    key_name = var.ssh_keyname
    user_data = base64encode(local.userdata)
    
    # instance_market_options {
    #     market_type = "spot"
    #     spot_options {
    #         block_duration_minutes = "360"
    #         spot_instance_type = "one-time"
    #         instance_interruption_behavior = "terminate"
    #     }
    # }

    # Network
    network_interfaces {
        associate_public_ip_address = true
        delete_on_termination = true
        subnet_id = var.subnet_id
        security_groups = local.security_group_ids
    }

    # Disk
    ebs_optimized = true
    block_device_mappings {
        device_name = "/dev/sda1"
        ebs {
            volume_size = 11
            delete_on_termination = true
        }
    }
    
    # Permissions
    iam_instance_profile {
        name = aws_iam_instance_profile.tf2_competitive.name
    }

    # Other
    monitoring {
        enabled = false
    }
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "terminate"
}
