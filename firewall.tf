# Allow home to access all instances
resource "google_compute_firewall" "firewall-allow-ingress-all-from-home" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-allow-ingress-all-from-home"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "INGRESS"
    priority = 1
    source_ranges = ["99.31.76.144/32"]
    allow {
        protocol = "tcp"
        ports = ["0-65535"]
    }
    allow {
        protocol = "udp"
        ports = ["0-65535"]
    }
}

resource "google_compute_firewall" "firewall-shared-allow-ingress-all-from-intranet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-shared-allow-ingress-all-from-intranet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "INGRESS"
    priority = 2
    source_ranges = ["10.0.0.0/8"]
    target_tags = ["shared-subnet"]
    allow {
        protocol = "tcp"
        ports = ["0-65535"]
    }
    allow {
        protocol = "udp"
        ports = ["0-65535"]
    }
}

resource "google_compute_firewall" "firewall-shared-deny-ingress-all-from-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-shared-deny-ingress-all-from-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "INGRESS"
    priority = 3
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["shared-subnet"]
    deny {
        protocol = "tcp"
        ports = ["0-65535"]
    }
    deny {
        protocol = "udp"
        ports = ["0-65535"]
    }
}

resource "google_compute_firewall" "firewall-shared-allow-egress-all-to-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-shared-allow-egress-all-to-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "EGRESS"
    priority = 2
    destination_ranges = ["0.0.0.0/0"]
    target_tags = ["shared-subnet"]
    allow {
        protocol = "tcp"
        ports = ["0-65535"]
    }
    allow {
        protocol = "udp"
        ports = ["0-65535"]
    }
}

resource "google_compute_firewall" "firewall-web-allow-ingress-http-from-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-web-allow-ingress-http-from-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "INGRESS"
    priority = 2
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["web-subnet"]
    allow {
        protocol = "tcp"
        ports = ["80", "443"]
    }
}

resource "google_compute_firewall" "firewall-web-allow-egress-all-to-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-web-allow-egress-all-to-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "EGRESS"
    priority = 2
    destination_ranges = ["0.0.0.0/0"]
    target_tags = ["web-subnet"]
    allow {
        protocol = "tcp"
        ports = ["0-65535"]
    }
    allow {
        protocol = "udp"
        ports = ["0-65535"]
    }
}

resource "google_compute_firewall" "firewall-sandbox-allow-ingress-ssh-from-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-sandbox-allow-ssh-ingress-from-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "INGRESS"
    priority = 1
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["sandbox-subnet"]
    deny {
        protocol = "tcp"
        ports = ["22"]
    }
}

resource "google_compute_firewall" "firewall-sandbox-deny-ingress-all-from-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-sandbox-deny-ingress-from-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "INGRESS"
    priority = 2
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["sandbox-subnet"]
    deny {
        protocol = "tcp"
        ports = ["0-65535"]
    }
}

resource "google_compute_firewall" "firewall-sandbox-allow-egress-all-to-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-sandbox-allow-egress-all-to-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "EGRESS"
    priority = 2
    destination_ranges = ["0.0.0.0/0"]
    target_tags = ["sandbox-subnet"]
    allow {
        protocol = "tcp"
        ports = ["0-65535"]
    }
    allow {
        protocol = "udp"
        ports = ["0-65535"]
    }
}

resource "google_compute_firewall" "firewall-gameserver-allow-ingress-srcds-from-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-gameserver-allow-ingress-srcds-from-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "INGRESS"
    priority = 3
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["gameserver-subnet"]
    allow {
        protocol = "tcp"
        ports = ["27015", "27020", "80", "443"]
    }
    allow {
        protocol = "udp"
        ports = ["27015"]
    }
}

resource "google_compute_firewall" "firewall-gameserver-allow-ingress-http-from-intranet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-gameserver-allow-ingress-http-from-intranet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "INGRESS"
    priority = 2
    source_ranges = ["10.0.0.0/8"]
    target_tags = ["gameserver-subnet"]
    allow {
        protocol = "tcp"
        ports = ["80", "443"]
    }
}

resource "google_compute_firewall" "firewall-gameserver-allow-egress-all-to-internet" {
    # Convention: <Resource>-<Subnet>-<Action>-<Direction>-<Service>-<To/From>-<Source/Destination>
    name = "firewall-gameserver-allow-egress-all-to-internet"
    network = "${google_compute_network.main-vpc.self_link}"
    direction = "EGRESS"
    priority = 2
    destination_ranges = ["0.0.0.0/0"]
    target_tags = ["gameserver-subnet"]
    allow {
        protocol = "tcp"
        ports = ["0-65535"]
    }
    allow {
        protocol = "udp"
        ports = ["0-65535"]
    }
}
