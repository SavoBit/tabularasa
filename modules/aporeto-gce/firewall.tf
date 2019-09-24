resource "google_compute_firewall" "swarm-nodes-in" {
  name = "${var.cluster_name}-swarm-node-firewall-ingress"
  network = "default"

  allow {
    protocol = "tcp"
    # Allo port for ui api doc tracing and monitoring
    ports = ["443", "1443", "2443", "3443", "4443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags =  ["${var.cluster_name}-swarm-masters"]

}
