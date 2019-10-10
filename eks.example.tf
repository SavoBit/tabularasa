module "aporeto-eks" {
  source = "git::https://github.com/aporeto-inc/tabularasa//modules/aporeto-eks"

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
      "owner" = "<owner>"
    }
    "passive" = {
      "owner" = "<owner>"
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
