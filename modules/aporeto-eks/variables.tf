# required

variable "cluster_name" {
  type        = "string"
  description = "The cluster name used as prefix."
}

variable "region" {
  type        = "string"
  description = "The region to use."
}

variable "vpc_cidr" {
  type        = "string"
  description = "The cidr to use for the vpc."
}

variable "vpc_private_subnets_cidr" {
  type        = "list"
  description = "The list of private subnets."
}

variable "vpc_public_subnets_cidr" {
  type        = "list"
  description = "The list of public subnets."
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Tags to set on nodes."
}
