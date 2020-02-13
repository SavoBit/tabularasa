terraform {
  backend "gcs" {
    # Name of the shared GCS bucket where to store the terraform states
    bucket = "<bucket name>"
    prefix = "production"
  }
}

provider "google" {
  # Specify google provider version
  version = "~> 2.20.2"
  # Path to your cloud provider's service account
  credentials = "${file("<path>")}"
  # Name of your cloud provider's project
  project     = "<project>"
}

module "aporeto-gke" {
  source = "git::https://github.com/aporeto-inc/tabularasa//modules/aporeto-gke"

  cluster_name               = "${local.cluster_name}"
  location                   = "${local.location}"
  disable_highwind_node_pool = "${local.disable_highwind_node_pool}"
}

locals {
  env = "${terraform.workspace}"

  # Define our setups
  names = {
    "active"  = "production-west"
    "passive" = "production-central"
  }

  locations = {
    "active"  = "us-west1"
    "passive" = "us-central1"
  }

  without_highwind = {
    "active"  = false
    "passive" = true
  }

  # set our vars
  cluster_name = "${lookup(local.names, local.env)}"
  location     = "${lookup(local.locations, local.env)}"

  disable_highwind_node_pool = "${lookup(local.without_highwind, local.env)}"

}
