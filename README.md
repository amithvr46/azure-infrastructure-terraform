# Azure Infrastructure — Terraform

Production-style Azure Landing Zone built with Terraform.
Modular, reusable, and ready to deploy.

Built by [Amith Busireddy](https://linkedin.com/in/busireddy-amith-761311181) 

---

## What This Deploys

A complete Azure Landing Zone with 4 modules:

| Module | Resource | Purpose |
|--------|----------|---------|
| `vnet` | Virtual Network + Subnets + NSG | Networking foundation |
| `aks` | AKS Cluster + Log Analytics | Kubernetes workloads |
| `keyvault` | Key Vault + Access Policies | Secrets management |
| `acr` | Container Registry | Docker image storage |

---

## Architecture
