resource "google_compute_global_forwarding_rule" "http_reddit" {
  project    = var.project
  # count      = var.http_forward ? 1 : 0
  name       = "reddit-global-forward-rule"
  target     = google_compute_target_http_proxy.http_proxy_reddit.self_link
  # ip_address = local.address
  port_range = "80"
}

resource "google_compute_target_http_proxy" "http_proxy_reddit" {
  project = var.project
  # count   = var.http_forward ? 1 : 0
  name    = "reddit-http-proxy"
  url_map = google_compute_url_map.url_map_reddit.self_link
}

resource "google_compute_url_map" "url_map_reddit" {
  project         = var.project
  # count           = var.create_url_map ? 1 : 0
  name            = "reddit-url-map"
  default_service = google_compute_backend_service.backend-reddit.self_link
}

resource "google_compute_backend_service" "backend-reddit" {

  project = var.project
  name    = "reddit-backend"
  description = "Backend for LB"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = google_compute_instance_group.reddit_group.self_link
  }

  health_checks = [google_compute_health_check.reddit_health.self_link]

  depends_on = [google_compute_health_check.reddit_health]
}

resource "google_compute_health_check" "reddit_health" {
  project = var.project
  name    = "reddit-hc"

  http_health_check {
    port         = 9292
    request_path = "/"
  }

  check_interval_sec = 5
  timeout_sec        = 5
}

resource "google_compute_instance_group" "reddit_group" {
  project   = var.project
  name      = "reddit-instance-group"
  zone      = var.gcp_zone
  instances = google_compute_instance.app.*.self_link
  /*instances = [
  	google_compute_instance.app.self_link,
  	google_compute_instance.app2.self_link,
  ]*/

  lifecycle {
    create_before_destroy = true
  }

  named_port {
    name = "http"
    port = 9292
  }
}
