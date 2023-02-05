# vpc
resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = false
  }

#subnets