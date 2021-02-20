provider "google" {
  credentials = file("account.json")
  project     = var.gcp_project_id
  region      = "europe-west-1"
}

module "network" {
  source           = "./network"
  environment      = var.environment
  subnetwork_cidrs = var.subnetwork_cidrs
  regions          = var.regions
}

module "machine_1" {
  source = "./instance"

  environment = var.environment
  region      = var.regions[0]
  subnet_id   = module.network.subnets[0]
  vpc_id      = module.network.vpc_id
  username    = var.username
}

module "machine_2" {
  source = "./instance"

  environment = var.environment
  region      = var.regions[1]
  subnet_id   = module.network.subnets[1]
  vpc_id      = module.network.vpc_id
  username    = var.username
}

output "one_key" {
  value = module.machine_1.key
}

output "one_ip" {
  value = module.machine_1.ip
}

output "two_key" {
  value = module.machine_2.key
}

output "two_ip" {
  value = module.machine_2.ip
}
