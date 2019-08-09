output "vpc_id" {
  value = "${google_compute_network.vpc1.id}"
}
output "subnet_id" {
  value = "${google_compute_subnetwork.subnet1.name}"
}
output "firewall_id" {
  value = "${google_compute_firewall.firewall.id}"
}


