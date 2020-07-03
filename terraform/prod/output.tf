output "app_external_ip" {
  value = module.app.app_external_ip
}

/*output "lb_external_ip" {
	value = google_compute_global_forwarding_rule.http_reddit.ip_address
}*/

output "vm_count" {
  value = "created ${var.instance_count} VM machines"
}
