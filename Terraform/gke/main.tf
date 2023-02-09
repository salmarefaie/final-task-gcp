resource "google_container_cluster" "gke" {
  name     = var.gke-name
  location = var.zone

  release_channel {
    channel = "STABLE"
  }

  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpcID
  subnetwork               = var.restricted-subnet

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.cidr-subnet
      display_name = var.sumnet-name
    }
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master-cidr
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.cluster-cidr
    services_ipv4_cidr_block = var.service-cidr
  }
}

resource "google_container_node_pool" "node-pool" {
  name       = var.node-name
  cluster    = google_container_cluster.gke.id
  node_count = 1
  location   = var.zone-node

  node_config {
    preemptible     = true
    machine_type    = var.machine-type
    service_account = var.gke-service-account

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

