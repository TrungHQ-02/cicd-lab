resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "3.35.4"
  values           = [file("../module/argo/argo-cd-setup/values/argocd.yaml")]
  depends_on       = [null_resource.update_kubeconfig]
}
# helm install argocd -n argocd -f values/argocd.yaml
resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name} --profile pmo && kubectl create namespace argocd && kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml && kubectl patch svc argocd-server -n argocd -p '{\"spec\": {\"type\": \"LoadBalancer\"}}'"
  } # Make sure this runs after the EKS cluster is created/updated
}

resource "null_resource" "download_ingress_controller" {
  provisioner "local-exec" {
    command = <<-EOT
      helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && kubectl create namespace nginx-ingress-sample && helm install my-nginx ingress-nginx/ingress-nginx --namespace nginx-ingress-sample --set controller.metrics.enabled=true --set-string "controller.metrics.service.annotations.prometheus.io/port"="10254" --set-string "controller.metrics.service.annotations.prometheus.io/scrape"="true"
    EOT
  }
}
