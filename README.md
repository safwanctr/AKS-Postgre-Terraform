# Infrastructure as Code (IaC) with Terraform and Azure 

This repository contains the Terraform configuration to set up a `dev` environment on Azure, which includes:

- Azure Virtual Network (VNet) with subnets for Azure Kubernetes Service (AKS) and PostgreSQL.
- Azure Kubernetes Service (AKS) for deploying your app.
- Azure PostgreSQL database for storing your application's data.
- Network Security Groups (NSGs) and firewall rules to control access.
- CI/CD integration for deploying containers using GHCR (GitHub Container Registry).

## Prerequisites

Before you start, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or above)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) (for Azure authentication)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (for interacting with Kubernetes clusters)

## Setup

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

### 2. Configure Azure CLI
Ensure you are logged into Azure via the Azure CLI. Run the following command to authenticate:

```bash
az login
```
This will open a browser window where you can log in with your Azure credentials. If you are logged into Azure CLI with a service principal, use the following command instead:

```bash
az login --service-principal -u <APP_ID> -p <PASSWORD> --tenant <TENANT_ID>
```

### 3. Configure Terraform Variables
You will need to configure a few variables for the Terraform configuration. Create a terraform.tfvars file with the following content (replace the values with your specific configurations):

```bash
# terraform.tfvars

location            = "East US"
resource_group_name = "rg-dev"
postgresql_admin_user     = "admin"
postgresql_admin_password = "your-strong-password"
postgresql_db_name        = "devdb"
ghcr_pat            = "your-ghcr-pat"
github_username     = "your-github-username"
github_email        = "your-github-email"
repo_name           = "your-repo-name"

```

### 4. Initialize Terraform
Run the following command to initialize Terraform:

```bash
terraform init
```

This will download the necessary provider plugins and prepare the working directory.

### 5. Apply the Terraform Configuration
Run the following command to apply the Terraform configuration and create the resources in Azure:

```bash
terraform apply
```

Terraform will show a preview of the resources it plans to create. Type yes to proceed and create the resources.

### 6. Kubernetes Cluster Configuration
Once the infrastructure is set up, you will need to configure kubectl to access your Azure Kubernetes Service (AKS) cluster.

Run the following command to configure kubectl with the newly created AKS cluster:

```bash
az aks get-credentials --resource-group rg-dev --name dev-cluster
```

### 7. Accessing the PostgreSQL Database
You can access the PostgreSQL database using the following credentials (provided as output by Terraform):

```bash
Host: your-postgresql-fqdn
Username: postgresql-admin-user
Password: postgresql-admin-password
Database Name: devdb
```
These details will be output once the Terraform apply process is complete.

### 8. Deploying Your Application
Once your infrastructure is ready, your application can be deployed to the AKS cluster. The Kubernetes deployment configuration uses a container from GitHub Container Registry (GHCR). Ensure that the Docker image is built and pushed to GHCR.

To deploy the app, use the following command:

```bash
kubectl apply -f deployment.yaml
```

### 9. Accessing Your Application
After the deployment, you can access your application using the external IP assigned by AKS. You can check the service details with the following command:

```bash
kubectl get svc
```

