resource "google_container_cluster" "aporeto" {
  name     = "${var.cluster_name}"
  location = "${var.location}"

  # required to create an empty cluster
  # This will create and delete the default node pool
  remove_default_node_pool = true
  initial_node_count       = 1
  ip_allocation_policy {
    use_ip_aliases = "${var.vpc_native}"
  }
  maintenance_policy {
    daily_maintenance_window {
      start_time = "${var.maintenance}"
    }
  }

  monitoring_service = "${var.monitoring}"
  logging_service    = "${var.logging}"
}


resource "google_container_node_pool" "aporeto-mongodb-node-pool" {
  count    = "${var.disable_mongodb_node_pool ? 0 : 1}"
  name     = "mongodb"
  location = "${var.location}"
  cluster  = "${google_container_cluster.aporeto.name}"

  node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = "${var.node_auto_scaling ? var.max_nodes_mongodb : 2}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  node_config {


    # TODO: Switch to ubuntu for XFS but require some changes
    image_type   = "Ubuntu"
    preemptible  = false
    machine_type = "n1-standard-32"


    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      type = "mongodb"
    }

    service_account = "${var.service_account}"

    tags = "${var.tags}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}



resource "google_container_node_pool" "aporeto-influxdb-node-pool" {
  count    = "${var.disable_influxdb_node_pool ? 0 : 1}"
  name     = "influxdb"
  location = "${var.location}"
  cluster  = "${google_container_cluster.aporeto.name}"

  node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = "${var.node_auto_scaling ? var.max_nodes_influxdb : 2}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  node_config {


    # TODO: Switch to ubuntu for XFS but require some changes
    image_type   = "COS"
    preemptible  = false
    machine_type = "n1-standard-32"


    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      type = "influxdb"
    }

    service_account = "${var.service_account}"

    tags = "${var.tags}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_container_node_pool" "aporeto-databases-node-pool" {
  count    = "${var.disable_databases_node_pool ? 0 : 1}"
  name     = "databases"
  location = "${var.location}"
  cluster  = "${google_container_cluster.aporeto.name}"

  node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = "${var.node_auto_scaling ? var.max_nodes_databases : 2}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  node_config {


    # TODO: Switch to ubuntu for XFS but require some changes
    image_type   = "COS"
    preemptible  = false
    machine_type = "n1-standard-8"


    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      type = "database"
    }

    service_account = "${var.service_account}"

    tags = "${var.tags}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}


resource "google_container_node_pool" "aporeto-services-node-pool" {
  count    = "${var.disable_services_node_pool ? 0 : 1}"
  name     = "services"
  location = "${var.location}"
  cluster  = "${google_container_cluster.aporeto.name}"

  node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = "${var.node_auto_scaling ? var.max_nodes_services : 2}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  node_config {

    # TODO: Switch to ubuntu for XFS but require some changes
    image_type = "COS"

    preemptible  = false
    machine_type = "n1-standard-4"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      type = "service"
    }

    service_account = "${var.service_account}"

    tags = "${var.tags}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}


resource "google_container_node_pool" "aporeto-monitoring-node-pool" {
  count    = "${var.disable_monitoring_node_pool ? 0 : 1}"
  name     = "monitoring"
  location = "${var.location}"
  cluster  = "${google_container_cluster.aporeto.name}"

  node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = "${var.node_auto_scaling ? var.max_nodes_monitoring : 2}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  node_config {

    # TODO: Switch to ubuntu for XFS but require some changes
    image_type = "COS"

    preemptible  = false
    machine_type = "n1-standard-4"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      type = "monitoring"
    }

    service_account = "${var.service_account}"

    tags = "${var.tags}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}


resource "google_container_node_pool" "aporeto-highwind-node-pool" {
  count    = "${var.disable_highwind_node_pool ? 0 : 1}"
  name     = "highwind"
  location = "${var.location}"
  cluster  = "${google_container_cluster.aporeto.name}"

  node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = "${var.node_auto_scaling ? var.max_nodes_highwind : 2}"
  }

  management {
    auto_repair  = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  node_config {

    # TODO: Switch to ubuntu for XFS but require some changes
    image_type = "COS"

    preemptible  = false
    machine_type = "n1-standard-4"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      type = "highwind"
    }

    service_account = "${var.service_account}"

    tags = "${var.tags}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
