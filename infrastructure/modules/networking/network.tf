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
    allow {
    protocol = "tcp"
    ports    = ["24007"]
  }
    allow {
    protocol = "tcp"
    ports    = ["24008"]
  }
    allow {
    protocol = "tcp"
    ports    = ["24009"]
  }
    allow {
    protocol = "tcp"
    ports    = ["38465"]
  }
    allow {
    protocol = "tcp"
    ports = ["38467"]
}
  allow {
    protocol = "tcp"
    ports    = ["49152"]
  }
    allow {
    protocol = "tcp"
    ports    = ["49153"]
  }
      allow {
    protocol = "tcp"
    ports    = ["8228"]
  }    
  allow {
    protocol = "tcp"
    ports    = ["4532"]
  }
    allow {
    protocol = "tcp"
    ports = ["9090"]
}
  allow {
    protocol = "tcp"
    ports    = ["9091"]
  }
    allow {
    protocol = "tcp"
    ports    = ["9093"]
  }
      allow {
    protocol = "tcp"
    ports    = ["9094"]
  }    
  allow {
    protocol = "tcp"
    ports    = ["9100"]
  }
}
