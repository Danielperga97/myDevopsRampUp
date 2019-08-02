provider "google" {
 credentials = "${file("/home/jenkins/Rampup-45f3b26c77de.json")}"
 project     = "ramp-up-247818"
 region      = "us-east1"
}

resource "random_id" "id" {
 byte_length = 4
}

resource "google_compute_network" "vpc1" {
  name                    = "vpc-${random_id.id.hex}"
  auto_create_subnetworks = "false"
}
resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet-${random_id.id.hex}"
  ip_cidr_range = "10.20.0.0/24"
  network       = "${google_compute_network.vpc1.name}"
  region        = "us-east1"
}
resource "google_compute_firewall" "firewall" {
  name    = "ramp-up-rules"
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

resource "google_compute_instance" "jenkins_instance" {
  name         = "jenkins-instance-${random_id.id.hex}"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"
  labels={
      role = "jenkins"
  }
  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }
  network_interface {
    subnetwork       = "${google_compute_subnetwork.subnet1.name}"
    access_config {
    }
  }
  metadata = {
      ssh-keys= "danielprga:${file("/home/jenkins/google_compute_engine.pub")}"
  }
}
resource "google_container_cluster" "gke-cluster" {
  name               = "gke-cluster-${random_id.id.hex}"
  network            = "${google_compute_network.vpc1.id}"
  subnetwork         = "${google_compute_subnetwork.subnet1.id}"
  location               = "us-east1-b"
  initial_node_count = 3


    node_config {
        #maquinas solo para pruebas de menos de 24 h
        preemptible  = true
        machine_type = "n1-standard-1"
    metadata = {
        ssh-keys= "danielprga:${file("/home/daniel/.ssh/google_compute_engine.pub")}"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.full_control",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]

      labels={
      role = "cluster-node"
  }
  }

}

