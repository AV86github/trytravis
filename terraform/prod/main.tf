terraform {
  # Версия terraform
  required_version = " ~>0.12.8"
}

provider "google" {
  # Версия провайдера
  version = "~> 2.15"

  # ID проекта
  project = var.project

  region = var.region
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  gcp_zone        = var.gcp_zone
  app_disk_image  = var.app_disk_image
  db_url          = module.db.db_internal_ip
  provisioner_ssh_key = var.provisioner_ssh_key
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  gcp_zone        = var.gcp_zone
  db_disk_image   = var.db_disk_image
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["83.242.179.192/32"]
}
