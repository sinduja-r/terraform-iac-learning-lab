# Namespace
resource "kubernetes_namespace_v1" "terraform-iac-learning" {
  metadata {
    name = var.namespace_name
  }
}

# Deployment
resource "kubernetes_deployment_v1" "terraform-iac-learning_app" {
  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace_v1.terraform-iac-learning.metadata[0].name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.replica_count

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = var.app_name
          image = "nginxdemos/hello" #For demo
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service_v1" "terraform-iac-learning_service" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = kubernetes_namespace_v1.terraform-iac-learning.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.terraform-iac-learning_app.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
