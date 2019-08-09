resource "google_compute_instance" "jenkins_instance" {
  name         = "${var.machine_name}"
  machine_type = "${var.machine_type}"
  zone         = "us-east1-b"
  labels={
      role = "jenkins"
  }
  boot_disk {
    initialize_params {
      image = "${var.machine_image}"
    }
  }
  network_interface {
    subnetwork       = "${var.subnetwork}"
    access_config {
    }
  }
  metadata = {
      ssh-keys= "danielprga:${file("/home/jenkins/google_compute_engine.pub")}"
  }
}