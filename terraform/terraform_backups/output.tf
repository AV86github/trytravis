output "app_external_ip" {
  value = google_compute_instance.app[*].network_interface[*].access_config[0].nat_ip
}

/*output "lb_external_ip" {
	value = google_compute_global_forwarding_rule.http_reddit.ip_address
}*/

output "vm_count" {
	value = "created ${var.instance_count} VM machines"
}
