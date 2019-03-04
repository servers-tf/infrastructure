locals = {
    subnets = [
        {name = "shared-subnet",            cidr_block = "10.0.0.0/22", region = "us-central1"},
        {name = "web-subnet",               cidr_block = "10.0.4.0/22", region = "us-central1"},
        {name = "sandbox-subnet",           cidr_block = "10.0.8.0/22", region = "us-central1"},
        {name = "usc1-gameserver-subnet",   cidr_block = "10.0.12.0/24", region = "us-central1"},
        {name = "use1-gameserver-subnet",   cidr_block = "10.0.13.0/24", region = "us-east1"},
        {name = "use4-gameserver-subnet",   cidr_block = "10.0.14.0/24", region = "us-east4"},
        {name = "usw1-gameserver-subnet",   cidr_block = "10.0.15.0/24", region = "us-west1"},
        {name = "usw2-gameserver-subnet",   cidr_block = "10.0.16.0/24", region = "us-west2"},
    ]
}

resource "google_compute_network" "main-vpc" {
    name = "main-vpc"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
    count = "${length(local.subnets)}"
    name = "${lookup(local.subnets[count.index], "name")}"
    ip_cidr_range = "${lookup(local.subnets[count.index], "cidr_block")}"
    region = "${lookup(local.subnets[count.index], "region")}"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}
