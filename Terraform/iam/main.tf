# permission for vm
resource "google_service_account" "vm_service_account" {
  account_id   = var.vm-sa-id
  display_name = var.vm-sa-name
}

resource "google_project_iam_binding" "role_vm" {
  project = var.project-id
  role    = var.vm-role
  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}",
  ]
}

# permission for gke
resource "google_service_account" "gke_service_account" {
  account_id   = var.gke-sa-id
  display_name = var.gke-sa-name
}

resource "google_project_iam_binding" "role_gke" {
  project = var.project-id
  role    = var.gke-role
  members = [
    "serviceAccount:${google_service_account.gke_service_account.email}",
  ]
}


