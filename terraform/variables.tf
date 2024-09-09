# # # # # # # # # # # 
# Civo configuration # 
# # # # # # # # # # # 

# The Civo Region to deploy the cluster in
variable "region" {
  type        = string
  default     = "LON1"
  description = "The region to provision the cluster against"
}

# # # # # # # # # # # # # 
# Cluster Configuration # 
# # # # # # # # # # # # # 

# The name of the cluster
variable "cluster_name" {
    type    = string
    default = "civo-navigate-berlin"
    description = "The name of the cluster to create"
}

# the node instance to use for the cluster
variable "cluster_node_size" {
    type    = string
    default = "g4s.kube.large"
    description = "The size of the node required for the cluster"
}

# the number of nodes to provision in the cluster
variable "cluster_node_count" {
  type        = number
  default     = "3"
  description = "The number of nodes to provision in the cluster"

}


# Database
variable "database_size" {
  description = "Size of the Database to create (multiples of 500)"
  type        = string
  default     = "g3.db.large"
}

variable "database_count" {
  description = "Number of Databases to create"
  type        = number
  default     = 1
}