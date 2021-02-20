variable "region" {
  type        = string
  description = "The subnet's location - e.g. europe-west1"
  default     = "europe-west3"
}

variable "ip_cidr_range" {
  type        = string
  description = "Subnet's CIDR, e.g. 10.0.0.0/16"
}

variable "vpc_id" { type = string }

variable "environment" { type = string }

variable "subnet_name" { type = string }

resource "google_compute_subnetwork" "subnet" {
  name                     = "${var.environment}-${var.subnet_name}"
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  network                  = var.vpc_id
  private_ip_google_access = true
  log_config {
    #  If log_config is present, flow logs are enabled
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

output "name" {
  value = google_compute_subnetwork.subnet.self_link
}
