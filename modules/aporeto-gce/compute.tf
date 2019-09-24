
resource "google_compute_instance" "swarm-master-nodes" {
  count = "${var.master_nodes_count}"
  name         = "${var.cluster_name}-swarm-node-${count.index}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  project = "${var.project}"
  tags = ["${var.cluster_name}-swarm-masters"]

  boot_disk {
    initialize_params {
      image = "${local.image["${var.flavor}"]}"
    }
  }

  scratch_disk {
  }

  network_interface {
    network            = "default"
    access_config {
      # Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  metadata {
    ssh-keys = "aporeto:${file("${var.ssh_key_path}")}"
    startup_script = <<SCRIPT
NO_INTERNET="${var.no_internet}"
${file("${path.module}/${local.startup_script["${var.flavor}"]}")}
SCRIPT
  }
}

resource "google_compute_instance" "swarm-worker-nodes" {
  count = "${var.worker_nodes_count}"
  name         = "${var.cluster_name}-swarm-node-${count.index}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  project = "${var.project}"
  tags = ["${var.cluster_name}-swarm-workers"]

  boot_disk {
    initialize_params {
      image = "${local.image["${var.flavor}"]}"
    }
  }

  scratch_disk {
  }

  network_interface {
    network            = "default"
    access_config {
      # Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  metadata {
    ssh-keys = "aporeto:${file("${path.module}/${var.ssh_key_path}")}"
    startup_script = <<SCRIPT
NO_INTERNET="${var.no_internet}"
${file("${path.module}/${local.startup_script["${var.flavor}"]}")}
SCRIPT
  }
}
