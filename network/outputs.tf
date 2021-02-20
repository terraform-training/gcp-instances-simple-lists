output "subnets" {
  value = [
    module.subnet_1.name,
    module.subnet_2.name,
  ]
}

output "vpc_id" {
  value = google_compute_network.vpc_network.id
}
