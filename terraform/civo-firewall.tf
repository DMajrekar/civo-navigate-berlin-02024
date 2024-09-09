# Create a firewall for the cluster
resource "civo_firewall" "cluster-firewall" {
  name                 = "${var.cluster_name}-firewall-cluster"
  network_id           = civo_network.network.id
  create_default_rules = false

  egress_rule {
    action     = "allow"
    cidr       = ["0.0.0.0/0", ]
    label      = "All UDP ports open"
    port_range = "1-65535"
    protocol   = "udp"
  }
  egress_rule {
    action   = "allow"
    cidr     = ["0.0.0.0/0", ]
    label    = "Ping/traceroute"
    protocol = "icmp"
  }
  egress_rule {
    action     = "allow"
    cidr       = ["0.0.0.0/0", ]
    label      = "All TCP ports open"
    port_range = "1-65535"
    protocol   = "tcp"
  }

  ingress_rule {
    # Add a firewall rule for port 80 allowing only 84.68.112.248/32
    action     = "allow"
    protocol   = "tcp"
    port_range = "6443"
    cidr       = ["0.0.0.0/0"]
  }

}

# Create a firewall for the database
resource "civo_firewall" "database-firewall" {
  name                 = "${var.cluster_name}-firewall-database"
  network_id           = civo_network.network.id
  create_default_rules = false

  egress_rule {
    action     = "allow"
    cidr       = ["0.0.0.0/0", ]
    label      = "All UDP ports open"
    port_range = "1-65535"
    protocol   = "udp"
  }

  egress_rule {
    action   = "allow"
    cidr     = ["0.0.0.0/0", ]
    label    = "Ping/traceroute"
    protocol = "icmp"
  }

  egress_rule {
    action     = "allow"
    cidr       = ["0.0.0.0/0", ]
    label      = "All TCP ports open"
    port_range = "1-65535"
    protocol   = "tcp"
  }

  ingress_rule {
    action     = "allow"
    protocol   = "tcp"
    port_range = "3306"
    cidr       = ["0.0.0.0/0"]
  }

}
