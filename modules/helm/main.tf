
resource "kubernetes_namespace" "grafana" {
  metadata {
    name = var.grafana_namespace
  }
}

resource "kubernetes_namespace" "kubernetes-dashboard" {
  metadata {
    name = var.kubernetes_dashboard_namespace
  }
}
resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = var.prometheus_namespace
  }
}
resource "helm_release" "kubernetes-dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  namespace  = kubernetes_namespace.kubernetes-dashboard.metadata.0.name
  set {
    name  = "replicaCount"
    value = var.kubernetes_dashboard_replicaCount
  }
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kube-prometheus"
  namespace  = kubernetes_namespace.prometheus.metadata.0.name
}
resource "kubernetes_namespace" "rabbitmq" {
  metadata {
    name = var.rabbitmq_namespace
  }
}
resource "helm_release" "rabbitmq" {
  name       = "rabbitmq"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq"
  namespace  = kubernetes_namespace.rabbitmq.metadata.0.name
  set {
    name  = "auth.username"
    value = var.rabbitmq_auth_username
  }
  set {
    name  = "auth.erlangCookie"
    value = var.rabbitmq_auth_erlangCookie
  }
  set {
    name  = "auth.password"
    value = var.rabbitmq_auth_password
  }
  set {
    name  = "replicaCount"
    value = var.rabbitmq_replica_count
  }
  set {
    name  = "metrics.enabled"
    value = var.rabbitmq_metrics_enabled
  }
  set {
    name  = "metrics.serviceMonitor.enabled"
    value = var.rabbitmq_metrics_serviceMonitor_enabled
  }
  set {
    name  = "metrics.plugins"
    value = var.rabbitmq_metrics_plugins
  }
  set {
    name  = "plugins"
    value = var.rabbitmq_plugins
  }

  depends_on = [
    helm_release.kube-prometheus
  ]
}
resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.grafana.metadata.0.name
  set {
    name  = "adminUser"
    value = var.grafana_admin_user
  }
  set {
    name  = "adminPassword"
    value = var.grafana_admin_password
  }
}
