variable "master_nodes_count" {
  default     = "3"
  description = "Number of swarm nodes to deploy."
}
variable "worker_nodes_count" {
  default     = "0"
  description = "Number of worker nodes to deploy."
}

variable "cluster_name" {
  description = "The cluster name used as prefix."
}

variable "machine_type" {
  default     = "n1-standard-1"
  description = "The machine type to use."
}

variable "region" {
  default     = "us-central1"
  description = "The regin to use."
}

variable "zone" {
  default     = "us-central1-a"
  description = "The gcp zone to use."
}

variable "project" {
  default     = "aporetodev"
  description = "The gcp project to use."
}

variable "ssh_key_path" {
  description = "The path of the ssh pub key to use."
}

variable "flavor" {
  default     = "ubuntu"
  description = "The flavor of os to deploy."
}

variable "no_internet" {
  default     = false
  description = "Disable internet access."
}

locals {
  image {
    ubuntu = "ubuntu-minimal-1804-bionic-v20180814"
  }

  startup_script {
    ubuntu = "scripts/ubuntu.sh"
  }
}
