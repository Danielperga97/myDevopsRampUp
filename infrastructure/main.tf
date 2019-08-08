provider "google" {
 credentials =  "${file("/home/jenkins/Rampup-45f3b26c77de.json")}"
 project     = "ramp-up-247818"
 region      = "us-east1"
}

resource "random_id" "id" {
 byte_length = 4
}

module "network" {
  source = "./modules/networking"
}

resource "google_compute_instance" "jenkins_instance" {
  name         = "jenkins-instance-1"
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
    subnetwork       = "${module.network.subnet_id}"
    access_config {
    }
  }
  metadata = {
      ssh-keys= "danielprga:${file("/home/jenkins/google_compute_engine.pub")}"
  }
}
resource "google_container_cluster" "gke-cluster" {
  name               = "gke-cluster-1"
  network            = "${module.network.vpc_id}"
  subnetwork         = "${module.network.subnet_id}"
  location           = "us-east1-b"
  initial_node_count = 3


    node_config {
        #maquinas solo para pruebas de menos de 24 h
        preemptible  = true
        machine_type = "n1-standard-1"
    metadata = {
        ssh-keys= "danielprga:${file("/home/jenkins/google_compute_engine.pub")}"
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

