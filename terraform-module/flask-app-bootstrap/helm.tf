
resource "helm_release" "flask_app" {

  name = "flask-app"

  chart      = var.chart_path
  repository = "helm-flask-app"
  namespace  = "default"

}