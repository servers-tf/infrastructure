locals = {
    gameserver-subnets = [
        {
            "region_name" = "us-central1",
            "subnet_link" = "${google_compute_subnetwork.usc1-gameserver-subnet.self_link}",
            "subnet_name" = "${google_compute_subnetwork.usc1-gameserver-subnet.name}"
        },
        {
            "region_name" = "us-east1",
            "subnet_link" = "${google_compute_subnetwork.use1-gameserver-subnet.self_link}",
            "subnet_name" = "${google_compute_subnetwork.use1-gameserver-subnet.name}"
        },
        {
            "region_name" = "us-east4",
            "subnet_link" = "${google_compute_subnetwork.use4-gameserver-subnet.self_link}",
            "subnet_name" = "${google_compute_subnetwork.use4-gameserver-subnet.name}"
        },
        {
            "region_name" = "us-west1",
            "subnet_link" = "${google_compute_subnetwork.usw1-gameserver-subnet.self_link}",
            "subnet_name" = "${google_compute_subnetwork.usw1-gameserver-subnet.name}"
        },
        {
            "region_name" = "us-west2",
            "subnet_link" = "${google_compute_subnetwork.usw2-gameserver-subnet.self_link}",
            "subnet_name" = "${google_compute_subnetwork.usw2-gameserver-subnet.name}"
        }
    ]
}


data "google_compute_image" "image-tf2-competitive" {
    family  = "tf2-competitive"
}

resource "google_compute_instance_template" "tf2-competitive" {
    count = "${length(local.gameserver-subnets)}"
    name = "instance-template-tf2-competitive-${lookup(local.gameserver-subnets[count.index], "region_name")}"
    tags = ["gameserver-subnet"]

    machine_type = "n1-standard-1"
    can_ip_forward = false

    scheduling {
        automatic_restart = false
        on_host_maintenance = "MIGRATE"
    }

    disk {
        source_image = "${data.google_compute_image.image-tf2-competitive.self_link}"
        boot = true
        auto_delete = true
        disk_type = "pd-ssd"
        disk_size_gb = 32
    }

    network_interface {
        subnetwork = "${lookup(local.gameserver-subnets[count.index], "subnet_link")}"
    }

    metadata {
        startup-script = "bash /opt/startup.sh"
        ttl = 240
    }
}
