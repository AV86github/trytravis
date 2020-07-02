variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable gcp_zone {
  description = "Zone"
}

variable db_url {
  description = "URL for MongoDB"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable provisioner_ssh_key {
  description = "Path to ssh key for VM"
}
