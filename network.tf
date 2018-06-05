resource "google_compute_network" "main-vpc" {
    # Convention: <Identifier>-<Resource>
    name = "main-vpc"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "shared-subnet" {
    # Convention: <Region>-<Resource>-<Identifier>
    # Location: Council Bluffs, Iowa
    # Purpose:
    # - For resources that are common to all members of the network
    # - TICK stack, ELK stack, etc
    # Firewall Rules:
    # - Not publically accessible
    # - Intranet accessible
    name = "shared-subnet"
    ip_cidr_range = "10.0.0.0/22"
    region = "us-central1"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "web-subnet" {
    # Convention: <Region>-<Resource>-<Identifier>
    # Location: Council Bluffs, Iowa
    # Purpose:
    # - Any web based frontends
    # Firewall Rules:
    # - Publically accessible
    name = "web-subnet"
    ip_cidr_range = "10.0.4.0/22"
    region = "us-central1"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "sandbox-subnet" {
    # Convention: <Region>-<Resource>-<Identifier>
    # Location: Council Bluffs, Iowa
    # Purpose:
    # - No Access to other subnets
    # - Running anything that needs complete isolation
    # Firewall Rules:
    # - No internet access
    # - No intranet acces
    name = "sandbox-subnet"
    ip_cidr_range = "10.0.8.0/22"
    region = "us-central1"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "usc1-gameserver-subnet" {
    # Convention: <Region>-<Resource>-<Identifier>
    # Location: Council Bluffs, Iowa
    # Purpose:
    # - Exclusive for gameservers in this region
    # Firewall Rules:
    # - Publically accessible
    name = "usc1-gameserver-subnet"
    ip_cidr_range = "10.0.12.0/24"
    region = "us-central1"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "use1-gameserver-subnet" {
    # Convention: <Region>-<Resource>-<Identifier>
    # Location: Moncks Corner, South Carolina
    # Purpose:
    # - Exclusive for gameservers in this region
    # Firewall Rules:
    # - Publically accessible
    name = "use1-gameserver-subnet"
    ip_cidr_range = "10.0.13.0/24"
    region = "us-east1"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "use4-gameserver-subnet" {
    # Convention: <Region>-<Resource>-<Identifier>
    # Location: Ashburn, Virginia
    # Purpose:
    # - Exclusive for gameservers in this region
    # Firewall Rules:
    # - Publically accessible
    name = "use4-gameserver-subnet"
    ip_cidr_range = "10.0.14.0/24"
    region = "us-east4"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "usw1-gameserver-subnet" {
    # Convention: <Region>-<Resource>-<Identifier>
    # Location: The Dalles, Oregon
    # Purpose:
    # - Exclusive for gameservers in this region
    # Firewall Rules:
    # - Publically accessible
    name = "usw1-gameserver-subnet"
    ip_cidr_range = "10.0.15.0/24"
    region = "us-west1"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "usw2-gameserver-subnet" {
    # Convention: <Region>-<Resource>-<Identifier>
    # Location: Los Angeles, California
    # Purpose:
    # - Exclusive for gameservers in this region
    # Firewall Rules:
    # - Publically accessible
    name = "usw2-gameserver-subnet"
    ip_cidr_range = "10.0.16.0/24"
    region = "us-west2"
    network = "${google_compute_network.main-vpc.self_link}"
    private_ip_google_access = "true"
}
