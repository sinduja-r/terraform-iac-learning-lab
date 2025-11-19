# Terraform + Kubernetes Lab using kind (Kubernetes in Docker)

This repository showcases a small, hands-on learning project where I used **Terraform** to deploy an application into a **local Kubernetes cluster** running on **kind** (Kubernetes in Docker).
The purpose of this project is to deepen my understanding of how **Infrastructure as Code (IaC)** applies to Kubernetes,and how Terraform can automate resource creation without relying on YAML or manual commands.


### Overview

Using Terraform, this project:
- Connects to a **local Kubernetes cluster** created with **kind**
- Creates a **namespace**
- Deploys a sample **web application** (`nginxdemos/hello`)
- Exposes it via a **ClusterIP Service**
- Lets you access the app locally using `kubectl port-forward`

**High-level architecture:**

<img width="867" height="281" alt="image" src="https://github.com/user-attachments/assets/e7def243-99df-4fdb-8387-f26ada667dda" />


### Tools & Prerequisites

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

#### Step 1 — Create a local Kubernetes cluster with kind

Run the following command to create a kind-based Kubernetes cluster:
```bash
kind create cluster --name terraform-k8-demo
```


#### Step 2 — Initialize & Apply Terraform

Inside the project directory:
```bash
terraform init
terraform apply
```
Plan : 3 to add, 0 to change, 0 to destroy.

Terraform will:
 - Create namespace
 - Deploy two pods
 - Expose it through a service
Approve the plan when prompted 

<img width="1480" height="186" alt="image" src="https://github.com/user-attachments/assets/7a474851-38ff-4e3a-aae3-9d525afe01cb" />


#### Step 3 — Verify the Deployment in Kubernetes

Check that the resources were created successfully:
```bash
kubectl get pods,svc -n <namespace>
``` 
Expected:
  - 2 running pods
  - 1 ClusterIP service
    
<img width="1175" height="185" alt="image" src="https://github.com/user-attachments/assets/1b54cfcf-61db-45e5-af73-4278dce57254" />


#### Step 4 — Access the Application

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


### Learning Reflections

Through this project, I gained hands-on experience with:
  - Using Terraform as an IaC approach to manage Kubernetes objects  
  - Setting up a lightweight Kubernetes environment using kind  
  - Understanding how Deployments, Services, and namespaces work together  
  - Automating resource creation instead of relying on manual YAML manifests
    

 ---

 # CI/CD: Terraform GitHub Actions Pipeline


### Objective

To automate basic Terraform checks using GitHub Actions and ensure every change to the repository is validated consistently. This workflow helps maintain clean, formatted, and syntactically correct Terraform code before any deployment.


#### Pipeline Stages

The GitHub Actions workflow performs the following automated steps on every push and pull request:

1. **Checks out the repository**  
   Ensures the workflow runs against the latest code.

2. **Sets up Terraform**  
   Installs the correct Terraform version inside the GitHub Actions runner.

3. **Checks code formatting (`terraform fmt -check`)**  
   Confirms that all Terraform files follow a consistent style.

4. **Initializes Terraform (`terraform init`)**  
   Runs initialization without requiring a remote backend.

5. **Validates the configuration (`terraform validate`)**  
   Ensures syntax correctness and catches structural issues early.

6. **Generates a Terraform execution plan (`terraform plan`)**  
   Produces a plan to show what Terraform intends to create or modify.

7. **Uploads the plan as an artifact**  
   Makes the `tf_plan` file available for download and review directly from GitHub Actions.



### Pipeline Output

After each workflow run, GitHub Actions provides:

- **A full log** of all Terraform commands  
- **A downloadable `tf_plan` artifact**  
- **Pass/Fail status** for the CI checks  

![Terraform CI](https://github.com/sinduja-r/terraform-iac-learning-lab/actions/workflows/terraform-ci.yml/badge.svg)

<img width="1384" height="580" alt="image" src="https://github.com/user-attachments/assets/f7812cf5-8145-4826-a0f2-c6bbe4cd307d" />
<img width="1375" height="138" alt="image" src="https://github.com/user-attachments/assets/36bd634d-ae33-465f-9234-3729ef920c17" />
<img width="1369" height="326" alt="image" src="https://github.com/user-attachments/assets/dcd41f84-cee2-4bfa-8f07-8e2bc53f2a98" />
