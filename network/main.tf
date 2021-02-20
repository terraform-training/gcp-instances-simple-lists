resource "google_compute_network" "vpc_network" {
  name                    = "${var.environment}-vpc"
  description             = "Main VPC"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL" # can be "GLOBAL"
}

module "subnet_1" {
  source = "./subnetwork"

  environment   = var.environment
  ip_cidr_range = var.subnetwork_cidrs[0]
  region        = var.regions[0]
  subnet_name   = "one"
  vpc_id        = google_compute_network.vpc_network.id
}

module "subnet_2" {
  source = "./subnetwork"

  environment   = var.environment
  ip_cidr_range = var.subnetwork_cidrs[1]
  region        = var.regions[1]
  subnet_name   = "two"
  vpc_id        = google_compute_network.vpc_network.id
}
