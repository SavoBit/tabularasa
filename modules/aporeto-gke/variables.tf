# required

variable "cluster_name" {
  type        = "string"
  description = "The cluster name used as prefix."
}

variable "location" {
  type        = "string"
  description = "The location to use. Either zone for a zonal cluster or region for a regional cluster."
}

# optionnal

variable "node_auto_scaling" {
  default     = true
  description = "Enable or disabled horizontal_pod_autoscaling."
}

variable "vpc_native" {
  default     = true
  description = "Enable or disabled the the vpc native (ip aliases)."
}

variable "auto_repair" {
  default     = true
  description = "Enable or disabled auto_repair."
}

variable "auto_upgrade" {
  default     = false
  description = "Enable or disabled auto_upgarade."
}

variable "maintenance" {
  type        = "string"
  default     = "03:00"
  description = "GMT time for starting maintenance window."
}

variable "monitoring" {
  type        = "string"
  default     = "none"
  description = "Monitoring service the cluster will use."
}

variable "logging" {
  type        = "string"
  default     = "none"
  description = "Logging service the cluster will use."
}

variable "service_account" {
  type        = "string"
  default     = ""
  description = "The services account the nodes will use."
}

variable "tags" {
  type        = "list"
  default     = []
  description = "Tags to set on nodes."
}

variable "max_nodes_databases" {
  default     = 10
  description = "max_nodes_database is the maximum value for node autoscale."
}

variable "disable_databases_node_pool" {
  default     = false
  description = "To disable databases node pool creation (usefull for a passive deployment)."
}

variable "max_nodes_services" {
  default     = 10
  description = "max_nodes_service is the maximum value for node autoscale."
}

variable "disable_services_node_pool" {
  default     = false
  description = "To disable services node pool creation (usefull for a passive deployment)."
}


variable "max_nodes_monitoring" {
  default     = 3
  description = "max_nodes_monitoring is the maximum value for node autoscale."
}

variable "disable_monitoring_node_pool" {
  default     = false
  description = "To disable monitoring node pool creation (usefull for a passive deployment)."
}

variable "max_nodes_highwind" {
  default     = 5
  description = "max_nodes_highwind is the maximum value for node autoscale."
}
variable "disable_highwind_node_pool" {
  default     = false
  description = "To disable highwind node pool creation (usefull for a passive deployment)."
}
