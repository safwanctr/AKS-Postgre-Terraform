resource "kubernetes_secret" "ghcr" {
  metadata {
    name      = "ghcr-secret-dev"
    namespace = "default"
  }

  data = {
    .dockerconfigjson = jsonencode({
      auths = {
        "https://ghcr.io" = {
          username = var.github_username
          password = var.ghcr_pat
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_deployment" "dev_app" {
  metadata {
    name      = "dev-app-deployment"
    namespace = "default"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "dev-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "dev-app"
        }
      }

      spec {
        container {
          name  = "dev-app-container"
          image = "ghcr.io/${var.github_username}/${var.repo_name}:latest"
          ports {
            container_port = 8080
          }
        }

        image_pull_secrets {
          name = "ghcr-secret-dev"
        }
      }
    }
  }
}
