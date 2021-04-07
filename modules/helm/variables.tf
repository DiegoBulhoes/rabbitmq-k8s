variable "kubernetes_dashboard_replicaCount" {
  default     = 3
  description = "kubernetes_dashboard_replicaCount"
}
variable "kubernetes_dashboard_namespace" {
  default     = "kubernetes-dashboard"
  description = "kubernetes_dashboard_namespace"
}
variable "grafana_namespace" {
  default     = "grafana"
  description = "grafana_namespace"
}
variable "prometheus_namespace" {
  default     = "prometheus"
  description = "prometheus_namespace"
}
variable "rabbitmq_namespace" {
  default     = "rabbitmq"
  description = "rabbitmq_namespace"
}
variable "rabbitmq_auth_username" {
  default     = "admin"
  description = "rabbitmq_auth_username"
}
variable "rabbitmq_auth_erlangCookie" {
  description = "rabbitmq_auth_erlangCookie"
}
variable "rabbitmq_auth_password" {
  description = "rabbitmq_auth_password"
}
variable "rabbitmq_replica_count" {
  default     = 3
  description = "rabbitmq_replica_count"
}
variable "rabbitmq_metrics_enabled" {
  default     = true
  description = "rabbitmq_metrics_enabled"
}
variable "rabbitmq_metrics_serviceMonitor_enabled" {
  default     = true
  description = "rabbitmq_metrics_serviceMonitor_enabled"
}
variable "rabbitmq_metrics_plugins" {
  default     = "rabbitmq_prometheus"
  description = "rabbitmq_metrics_plugins"
}
variable "rabbitmq_plugins" {
  default     = "rabbitmq_management rabbitmq_peer_discovery_k8s rabbitmq_prometheus"
  description = "rabbitmq_plugins"
}
variable "grafana_admin_user" {
  default     = "admin"
  description = "admin"
}
variable "grafana_admin_password" {
  default     = "admin"
  description = "admin"
}

