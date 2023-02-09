# vpc
resource "google_compute_network" "vpc" {
  name                    = var.vpc-name
  auto_create_subnetworks = var.auto-subnets
  routing_mode            = var.routing-mode
}

# subnets
resource "google_compute_subnetwork" "subnets" {
  for_each      = var.subnet
  name          = each.key
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.vpc.id
}

# router
resource "google_compute_router" "router" {
  name    = var.router-name
  network = google_compute_network.vpc.id
  region  = google_compute_subnetwork.subnets["management-subnet"].region
}

# nat   
resource "google_compute_router_nat" "nat" {
  name                               = var.nat-name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnets["management-subnet"].id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}