resource "civo_database" "database" {
  name        = "${var.cluster_name}superset-mgmt"
  region      = var.region
  size        = var.database_size
  nodes       = var.database_count
  engine      = "PostgreSQL"
  version     = "14"
  network_id  = civo_network.network.id
  firewall_id = civo_firewall.database-firewall.id

  depends_on = [ civo_kubernetes_cluster.cluster ]
}

