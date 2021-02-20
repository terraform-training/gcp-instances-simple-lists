output "key" {
  value = tls_private_key.access_ssh_key.private_key_pem
}

output "ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
