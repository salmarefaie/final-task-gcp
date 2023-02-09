output "vm-sa-email" {
  value = google_service_account.vm_service_account.email
}

output "gke-sa-email" {
  value = google_service_account.gke_service_account.email
}