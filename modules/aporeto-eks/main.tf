terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = ">= 2.11"
  region  = "${var.region}"
}

provider "random" {
  version = "~> 2.1"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

data "aws_availability_zones" "available" {
}

locals {
  cluster_name = "${var.cluster_name}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name                 = "${var.cluster_name}-vpc"
  cidr                 = "${var.vpc_cidr}"
  azs                  = "${slice(data.aws_availability_zones.available.names, 0, length(var.vpc_private_subnets_cidr))}"
  private_subnets      = var.vpc_private_subnets_cidr
  public_subnets       = var.vpc_public_subnets_cidr
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  subnets      = module.vpc.private_subnets

  tags = "${var.tags}"

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                 = "${var.cluster_name}-databases"
      instance_type        = "m4.2xlarge"
      kubelet_extra_args   = "--node-labels=type=database"
      asg_desired_capacity = 3
    },
    {
      name                 = "${var.cluster_name}-services"
      instance_type        = "m4.2xlarge"
      kubelet_extra_args   = "--node-labels=type=service"
      asg_desired_capacity = 3
    },
    {
      name                 = "${var.cluster_name}-monitoring"
      instance_type        = "m4.xlarge"
      kubelet_extra_args   = "--node-labels=type=monitoring"
      asg_desired_capacity = 3
    },
    {
      name                 = "${var.cluster_name}-highwind"
      instance_type        = "m4.xlarge"
      kubelet_extra_args   = "--node-labels=type=highwind"
      asg_desired_capacity = 3
    },
  ]
}
