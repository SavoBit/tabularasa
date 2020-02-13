# Tabula Rasa

This repository contains a set of terraform modules to deploy the kubernetes infrastructure
that can host the control plane.

Currently, two Kubernetes environments are currently supported:

1) [GKE](README-gke.md)
2) [EKS](README-eks.md)

## Terraform version

Starting Terraform interpolation syntax has changed starting version 0.12.
Make sure you have an earlier version.

Until we migrate these modules, we recommend using [Terraform 0.11.14](https://www.terraform.io/downloads.html).

## Kubernetes requirements

Before you proceed, make sure you have:

* Authorizations to manage your Kubernetes infrastructure.
* Quotas set to 800 in the region you deploy the control plane.
