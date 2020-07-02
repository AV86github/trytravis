terraform {
	backend "gcs" {
		bucket = "storage-bucket-avl"
		prefix = "stage"
	}
}
