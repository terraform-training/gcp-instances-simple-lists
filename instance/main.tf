data "google_compute_zones" "available" {
  region = var.region
}

locals {
  ssh_tag = "${random_pet.machine.id}-ssh"
}

resource "random_pet" "machine" {
  length = 1
}

resource "tls_private_key" "access_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "google_compute_instance" "vm_instance" {
  name                = random_pet.machine.id
  zone                = data.google_compute_zones.available.names[0]
  machine_type        = "f1-micro"
  can_ip_forward      = false
  deletion_protection = false

  boot_disk {
    auto_delete = true
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    subnetwork = var.subnet_id
    network    = var.vpc_id
    access_config {
      # Leaving this empty results in ephemeral external IP
    }
  }

  tags = [local.ssh_tag]

  metadata = {
    ssh-keys = "${var.username}:${tls_private_key.access_ssh_key.public_key_openssh}"
  }

}

resource "google_compute_firewall" "ssh_allow" {
  name    = "${var.environment}-${local.ssh_tag}"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [local.ssh_tag]
}
