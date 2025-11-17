terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
  }

  required_version = ">= 1.0"
}

provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.cluster_context
}
