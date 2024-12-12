# Dev Environment Infrastructure Setup

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
