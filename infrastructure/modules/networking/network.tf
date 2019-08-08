resource "google_compute_network" "vpc1" {
  name                    = "${var.vpc_name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "${var.subnet1_name}"
  ip_cidr_range = "${var.subnet1_cidr}"
  network       = "${google_compute_network.vpc1.name}"
  region        = "us-east1"
}

resource "google_compute_firewall" "firewall" {
  name    = "${var.firewall1_name}"
  network = "${google_compute_network.vpc1.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
    allow {
    protocol = "tcp"
    ports    = ["80"]
  }
    allow {
    protocol = "tcp"
    ports    = ["3000"]
  }
    allow {
    protocol = "tcp"
    ports    = ["3030"]
  }
    allow {
    protocol = "tcp"
    ports = ["8080"]
}
}