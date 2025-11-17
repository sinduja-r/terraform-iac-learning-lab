output "namespace" {
  description = "Namespace where the resources were created"
  value       = kubernetes_namespace_v1.terraform-iac-learning.metadata[0].name
}

output "service_name" {
  description = "Name of the service exposing the app"
  value       = kubernetes_service_v1.terraform-iac-learning_service.metadata[0].name
}

output "kubectl_port_forward_command" {
  description = "Port-forward command to access the app"
  value       = "kubectl port-forward -n ${kubernetes_namespace_v1.terraform-iac-learning.metadata[0].name} svc/${kubernetes_service_v1.terraform-iac-learning_service.metadata[0].name} 8080:80"
}
