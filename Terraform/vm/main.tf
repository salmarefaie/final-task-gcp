# vm
resource "google_compute_instance" "vm" {
  name         = "private-vm"
  zone         = "us-central1-a"
  machine_type = "f1-micro"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      type  = "pd-standard"
    }
  }
  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }

  tags = ["ssh"]

  network_interface {
    network    = var.vpcID
    subnetwork = var.management-subnet
  }

}

# firewall for vm 
resource "google_compute_firewall" "ssh" {
  name    = "ssh-firewall"
  network = var.vpcID

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["ssh"]
  source_ranges = ["35.235.240.0/20"]
}