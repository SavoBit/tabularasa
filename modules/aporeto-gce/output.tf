

output "master_ip" {
  value = "${join(" ", google_compute_instance.swarm-master-nodes.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}
output "worker_ip" {
  value = "${join(" ", google_compute_instance.swarm-worker-nodes.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}
