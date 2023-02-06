# permission for gke and vm
resource "google_service_account" "service_account" {
  account_id   = "service-account"
  display_name = "service account for GKE & VM"
}

resource "google_project_iam_binding" "project" {
  project = "mineral-order-375711"
  for_each = var.role
  role    = each.value
  members = [
     "serviceAccount:${google_service_account.service_account.email}",
  ]
}

