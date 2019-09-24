# Tabula rasa

This repository contains a set of terraform modules for different provider aim to deploy infrastructure that will hold the control plane.

They are grouped by providers.

## Example of usage

Create a folder like `production/eks` and create a `main.tf` as:

```hcl

module "aporeto-eks" {
  source = "../../modules/aporeto-eks"

  cluster_name             = "${local.cluster_name}"
  region                   = "${local.region}"
  vpc_cidr                 = "${local.vpc_cidr}"
  vpc_private_subnets_cidr = "${local.vpc_private_subnets_cidr}"
  vpc_public_subnets_cidr  = "${local.vpc_public_subnets_cidr}"
  tags                     = "${local.tags}"
}

locals {
  env = "${terraform.workspace}"

  # Define our setups
  names = {
    "active"  = "production-west"
    "passive" = "production-central"
  }

  regions = {
    "active"  = "us-west-2"
    "passive" = "us-east-1"
  }

  vpc_cidrs = {
    "active"  = "10.0.0.0/16"
    "passive" = "11.0.0.0/16"
  }

  vpc_private_subnets_cidrs = {
    "active" = ["10.0.1.0/24", "10.0.2.0/24"]
    "pasive" = ["11.0.1.0/24", "11.0.2.0/24"]
  }
  vpc_public_subnets_cidrs = {
    "active" = ["10.1.1.0/24", "10.1.2.0/24"]
    "pasive" = ["11.1.1.0/24", "11.1.2.0/24"]
  }

  tagss = {
    "active" = {
      "owner" = "cyril"
    }
    "passive" = {
      "owner" = "cyril"
    }
  }

  # set our vars
  cluster_name             = "${lookup(local.names, local.env)}"
  region                   = "${lookup(local.regions, local.env)}"
  vpc_cidr                 = "${lookup(local.vpc_cidrs, local.env)}"
  vpc_private_subnets_cidr = "${lookup(local.vpc_private_subnets_cidrs, local.env)}"
  vpc_public_subnets_cidr  = "${lookup(local.vpc_public_subnets_cidrs, local.env)}"
  tags                     = "${lookup(local.tagss, local.env)}"
}
```

Check each modules README to see the variables you can set using the pattern above then `terraform init`

This leverage the use of workspace and local var. So by default it will not be happy if you do terraform validate.

You will have to create workspace that matches your configuration like `terraform workspace new active` and `terraform workspace new passive` then select the one you want to work on with `terraform workspace select <workspace>`.

> Note: Use of a shared storage bucket to store the `tf-state` is greatly recommended as described above. The bucket must exist prior to issue `terraform init`

Then as usual terraform plan / apply / destroy with the selected workspace.
