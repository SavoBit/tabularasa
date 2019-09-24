# Tabula rasa

This repository contains a set of terraform modules for different provider aim to deploy infrastructure that will hold the control plane.

They are grouped by providers.

## Example of usage

Create a folder like `production/gke` and create a `main.tf` as:

```hcl
terraform {
  backend "gcs" {
    bucket = "<bucket name>"
    prefix = "production"
  }
}

provider "google" {
  credentials = "${file("<path>")}"
  project     = "<project>"
}

module "aporeto-gke" {
  source = "../../modules/aporeto-gke"

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
```

Check each modules README to see the variables you can set using the pattern above then `terraform init`

This leverage the use of workspace and local var. So by default it will not be happy if you do terraform validate.

You will have to create workspace that matches your configuration like `terraform workspace new active` and `terraform workspace new passive` then select the one you want to work on with `terraform workspace select <workspace>`.

> Note: Use of a shared storage bucket to store the `tf-state` is greatly recommended as described above. The bucket must exist prior to issue `terraform init`

Then as usual terraform plan / apply / destroy with the selected workspace.
