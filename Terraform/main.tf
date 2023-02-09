module "network" {
  source = "./network"

  vpc-name     = "vpc"
  router-name  = "router-for-nat"
  nat-name     = "nat"
  routing-mode = "REGIONAL"
  auto-subnets = false

  subnet = {
    "management-subnet" = { cidr = "10.0.0.0/24", region = "us-central1" },
    "restricted-subnet" = { cidr = "10.0.6.0/24", region = "us-central1" },
  }
}

module "iam" {
  source      = "./iam"
  vm-role     = "roles/container.admin"
  gke-role    = "roles/storage.objectViewer"
  project-id  = "mineral-order-375711"
  vm-sa-id    = "service-account-vm"
  vm-sa-name  = "service account for VM"
  gke-sa-id   = "service-account-gke"
  gke-sa-name = "service account for GKE"
}

module "vm" {
  source            = "./vm"
  service_account   = module.iam.vm-sa-email
  vpcID             = module.network.vpc-id
  management-subnet = module.network.management-subnet-id
}

module "gke" {
  source              = "./gke"
  vpcID               = module.network.vpc-id
  restricted-subnet   = module.network.restricted-subnet-id
  gke-name            = "gke"
  zone                = "us-central1-a"
  cidr-subnet         = "10.0.0.0/24"
  sumnet-name         = "managment-subnet-cidr"
  machine-type        = "g1-small"
  node-name           = "node-pool"
  master-cidr         = "172.16.0.0/28"
  cluster-cidr        = "10.16.0.0/16"
  service-cidr        = "10.12.0.0/16"
  zone-node           = "us-central1-b"
  gke-service-account = module.iam.gke-sa-email
}