output "vpc-id" {
  value = google_compute_network.vpc.id
}

output "management-subnet-id" {
  value = google_compute_subnetwork.subnets["management-subnet"].id
}

output "restricted-subnet-id" {
  value = google_compute_subnetwork.subnets["restricted-subnet"].id
}