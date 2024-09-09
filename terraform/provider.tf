terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.1.2"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
  }
}

# Configure the Civo Provider
provider "civo" {
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = civo_kubernetes_cluster.cluster.api_endpoint
    client_certificate     = base64decode(yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).users[0].user.client-certificate-data)
    client_key             = base64decode(yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).clusters[0].cluster.certificate-authority-data)
  }
}

provider "kubernetes" {
  host                   = civo_kubernetes_cluster.cluster.api_endpoint
  client_certificate     = base64decode(yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(civo_kubernetes_cluster.cluster.kubeconfig).clusters[0].cluster.certificate-authority-data)
}
