variable "project" {
  description = "project id"
}
variable "region" {
  default     = "us-central1"
  description = "region"
}
variable "location" {
  description = "location"
  default     = "us-central1-a"
}
variable "node_locations" {
  description = "node_locations"
  default = [
    "us-central1-b",
    "us-central1-c",
  ]
}
variable "gke_username" {
  default     = "ks8"
  description = "gke username"
}
variable "gke_password" {
  default     = "password"
  description = "gke password"
}
variable "ip_cidr_range" {
  default     = "10.10.0.0/24"
  description = "ip cidr range"
}
variable "machine_type" {
  default     = "n1-standard-1"
  description = "machine type"
}
variable "initial_node_count" {
  default     = 2
  description = "initial node count"
}
variable "remove_default_node_pool" {
  default     = "true"
  description = "remove default node pool"
}
variable "min_node_count" {
  default     = 2
  description = "min_node_count"
}
variable "max_node_count" {
  default     = 3
  description = "max_node_count"
}
variable "auto_upgrade" {
  default     = true
  description = "auto_upgrade"
}
variable "auto_repair" {
  default     = true
  description = "auto_repair"
}
variable "oauth_scopes" {
  default = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/trace.append",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
  ]
  description = "oauth_scopes"
}


variable "install_apps" {
  default     = false
  description = "install_apps"
}
variable "config_path" {
  description = "config_path_k8s"
  default     = "~/.kube/config"
}
variable "name_provider" {
  description = "provider_k8s"
  default     = "google"
}
variable "rabbitmq_auth_password" {
  description = "rabbitmq_auth_password"
}
variable "rabbitmq_auth_erlangCookie" {
  description = "rabbitmq_auth_erlangCookie"
}
variable "rabbitmq_auth_username" {
  description = "rabbitmq_auth_username"
  default     = "admin"
}

