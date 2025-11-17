variable "kubeconfig_path" {
  description = "Kubeconfig file path"
  type        = string
  default     = "C:/Users/sindu/.kube/config"
}

variable "cluster_context" {
  description = "Name of the Kubernetes context"
  type        = string
  default     = "kind-terraform-k8-demo"
}

variable "namespace_name" {
  description = "Namespace where app will be deployed"
  type        = string
  default     = "terraform-iac-learning"
}

variable "app_name" {
  description = "Application name label"
  type        = string
  default     = "terraform-iac-learning"
}

variable "replica_count" {
  description = "Number of replicas for the app"
  type        = number
  default     = 2
}
