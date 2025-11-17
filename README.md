# Terraform + Kubernetes Lab using kind (Kubernetes in Docker)

This repository showcases a small, hands-on learning project where I used **Terraform** to deploy an application into a **local Kubernetes cluster** running on **kind** (Kubernetes in Docker).
The purpose of this project is to deepen my understanding of how **Infrastructure as Code (IaC)** applies to Kubernetes,and how Terraform can automate resource creation without relying on YAML or manual commands.


## Overview

Using Terraform, this project:
- Connects to a **local Kubernetes cluster** created with **kind**
- Creates a **namespace**
- Deploys a sample **web application** (`nginxdemos/hello`)
- Exposes it via a **ClusterIP Service**
- Lets you access the app locally using `kubectl port-forward`

**High-level architecture:**

<img width="867" height="281" alt="image" src="https://github.com/user-attachments/assets/e7def243-99df-4fdb-8387-f26ada667dda" />


## Tools & Prerequisites

- **Terraform**    : Manages Kubernetes resources using IaC
- **Kubernetes**   : Container orchestration platform
- **kind** (Kubernetes inside Docker) : Creates the local Kubernetes cluster
- **Docker Desktop** : Required for running the kind and Kubernets nodes
- **kubectl CLI**    : Interacts with the Kubernetes cluster
- `nginxdemos/hello` demo image : Sample container image deployed via Terraform

Verify Installations:
```bash
docker --version
kubectl version --client
kind --version
terraform -v
```

**Project Structure**
```
.
├── provider.tf — Configures Terraform and the Kubernetes provider
├── variables.tf — Contains kubeconfig path, context, and app variables
├── main.tf — Defines namespace, deployment, and service
└── outputs.tf — Prints namespace, service name, and port-forward command
```

## Step 1 — Create a local Kubernetes cluster with kind

Run the following command to create a kind-based Kubernetes cluster:
```bash
kind create cluster --name terraform-k8-demo
```


## Step 2 — Initialize & Apply Terraform

Inside the project directory:
```bash
terraform init
terraform apply
```

Terraform will:
 - Create namespace
 - Deploy two pods
 - Expose it through a service
   
Approve the plan when prompted 


## Step 3 — Verify the Deployment in Kubernetes

Check that the resources were created successfully:
```bash
kubectl get pods,svc -n <namespace>
``` 
Expected:
  - 2 running pods
  - 1 ClusterIP service
    
<img width="1175" height="185" alt="image" src="https://github.com/user-attachments/assets/1b54cfcf-61db-45e5-af73-4278dce57254" />


## Step 4 — Access the Application

Use port-forwarding:
``` bash
kubectl port-forward -n <namespace> svc/<service-name> 8080:80
```
Open the app in your browser: 
     http://localhost:8080
(You will see the nginxdemos/hello demo page)


**Cleanup**

To remove all Kubernetes resources created by Terraform:
```bash
terraform destroy
```

To delete the kind cluster:
```bash
kind delete cluster --name terraform-k8-demo
```


## Learning Reflections

Through this project, I gained hands-on experience with:
  - Using Terraform as an IaC approach to manage Kubernetes objects  
  - Setting up a lightweight Kubernetes environment using kind  
  - Understanding how Deployments, Services, and namespaces work together  
  - Automating resource creation instead of relying on manual YAML manifests  

 

