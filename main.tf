terraform {
  required_version = ">= 0.12"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.54.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.3"
    }
  }
}

provider "kubernetes" {
  config_path = var.config_path
  alias       = "k8s"
}
provider "helm" {
  kubernetes {
    config_path = var.config_path
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_network" "vpc" {
  name                    = "${var.project}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.ip_cidr_range
}

resource "google_container_cluster" "primary" {
  name       = "gke-cluster-${var.project}"
  location   = var.location
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  node_locations = var.node_locations

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  remove_default_node_pool = var.remove_default_node_pool

  initial_node_count = var.initial_node_count
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name               = "preemptible-nodes-${var.project}"
  project            = var.project
  location           = var.location
  cluster            = google_container_cluster.primary.name
  initial_node_count = var.initial_node_count

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = var.oauth_scopes
  }

  depends_on = [
    google_container_cluster.primary
  ]
}

module "helm" {
  count  = var.install_apps ? 1 : 0
  source = "./modules/helm"
  providers = {
    kubernetes = kubernetes.k8s
  }

  depends_on = [
    google_container_node_pool.primary_preemptible_nodes,
    google_container_cluster.primary
  ]
}
