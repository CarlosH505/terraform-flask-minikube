output "flask_app_url" {
  value = kubernetes_service.flask_app.status[0].load_balancer[0].ingress[0].ip

}