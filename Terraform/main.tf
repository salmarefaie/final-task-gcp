module "network" {
  source = "./network"

  vpc-name     = "vpc"
  router-name  = "router-for-nat"
  nat-name     = "nat"
  routing-mode = "REGIONAL"
  auto-subnets = false

  subnet = {
    "management-subnet" = { cidr = "10.0.0.0/24", region = "us-central1" },
    "restricted-subnet" = { cidr = "10.0.6.0/24", region = "europe-west1" },
  }
}

module "iam" {
  source = "./iam"
  role = {
    "role1" = "roles/container.admin",
    "role2" = "roles/compute.admin",
  }
}

module "vm" {
  source            = "./vm"
  service_account   = module.iam.sa-email
  vpcID             = module.network.vpc-id
  management-subnet = module.network.management-subnet-id
}

