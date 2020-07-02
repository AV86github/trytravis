variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable gcp_zone {
  description = "Zone for gcp VM"
  default     = "europe-west1-b"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
