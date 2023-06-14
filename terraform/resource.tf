resource "random_string" "cluster_suffix" {
  length  = var.suffix_length
  special = false
}
