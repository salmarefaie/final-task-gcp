resource "google_container_cluster" "gke" {
  name     = "gke"
  location = "us-central1-a"

  release_channel {
    channel = "STABLE"
  }

  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpcID
  subnetwork               = var.restricted-subnet

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/24"
      display_name = "managment-subnet-cidr"
    }
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.16.0.0/16"
    services_ipv4_cidr_block = "10.12.0.0/16"
  }

}

resource "google_container_node_pool" "node-pool" {
  name       = "node-pool"
  cluster    = google_container_cluster.gke.id
  node_count = 1
  location   = "us-central1-b"

  node_config {
    preemptible  = true
    machine_type = "g1-small"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

