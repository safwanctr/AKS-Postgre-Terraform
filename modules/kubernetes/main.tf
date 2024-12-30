/*
resource "kubernetes_secret" "ghcr" {
  metadata {
    name      = "ghcr-secret-dev"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "ghcr.io" = {
          username = var.github_username
          password = var.ghcr_pat
          auth     = base64encode("${var.github_username}:${var.ghcr_pat}")
        }
      }
    }))
  }

  type = "kubernetes.io/dockerconfigjson"
}
*/

resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend-deployment"
    namespace = "default"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend-container"
          image = "ghcr.io/${var.github_username}/${var.frontend_repo_name}:latest"
          port {
            container_port = 3000  # Expose port 3000 for frontend
          }
        env {
            name  = "NEXT_PUBLIC_BACKEND_URL"
            value = "http://backend-service.default.svc.cluster.local:8000"
          }
        }

      # image_pull_secrets {
      #    name = "ghcr-secret-dev"
      #  }
      }
    }
  }
}

resource "kubernetes_service" "frontend_service" {
  metadata {
    name      = "frontend-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "frontend"
    }

    port {
      port        = 80     
      target_port = 3000
    }

    type = "LoadBalancer"  # Use LoadBalancer if you want external access
  }
}

resource "kubernetes_deployment" "backend" {

  
  metadata {
    name      = "backend-deployment"
    namespace = "default"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name  = "backend-container"
          image = "ghcr.io/${var.github_username}/${var.backend_repo_name}:latest"

        

          
          port {
            container_port = 8000  # Expose port 8000 for backend
          }
        }

     #   image_pull_secrets {
     #     name = "ghcr-secret-dev"
     #   }
      }
    }
  }
}

resource "kubernetes_service" "backend_service" {
  metadata {
    name      = "backend-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "backend"
    }

    port {
      port        = 8000       # Expose service on port 8000
      target_port = 8000
    }

    type = "LoadBalancer"  # Internal service only
  }
}
