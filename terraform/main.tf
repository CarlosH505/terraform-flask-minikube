provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "flask_app" {
  metadata {
    name = "flask-app"
    labels = {
      app = "flask-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "flask-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask-app"
        }
      }

      spec {
        container {
          image = "localhost:5000/app-oi-mundo:latest"
          name  = "flask-app"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "flask_app" {
  metadata {
    name = "flask-app"
  }

  spec {
    selector = {
      app = "flask-app"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 5000
    }
  }
}