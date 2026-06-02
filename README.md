# Azure Infrastructure — Terraform

Production-style Azure Landing Zone built with Terraform.
Modular, reusable, and ready to deploy.

Built by [Amith Busireddy](https://linkedin.com/in/busireddy-amith-761311181) —
Cloud DevOps Engineer with 6 years of experience at Wells Fargo,
Fidelity Investments, AT&T, and Comcast.

---

## What This Deploys

A complete Azure Landing Zone with 4 reusable modules:

| Module | Resource | Purpose |
|--------|----------|---------|
| vnet | Virtual Network + Subnets + NSG | Networking foundation |
| aks | AKS Cluster + Log Analytics | Kubernetes workloads |
| keyvault | Key Vault + Access Policies | Secrets management |
| acr | Container Registry | Docker image storage |

---

## Architecture

```
Azure Subscription
└── Resource Group: rg-azure-infra-dev
    ├── VNet: vnet-azinfra-dev (10.0.0.0/16)
    │   ├── Subnet: snet-aks  (10.0.1.0/24)
    │   ├── Subnet: snet-app  (10.0.2.0/24)
    │   └── Subnet: snet-data (10.0.3.0/24)
    ├── AKS Cluster: aks-azinfra-dev
    │   ├── Autoscaler: min 1, max 5 nodes
    │   ├── Identity: System-assigned managed identity
    │   └── Monitoring: Log Analytics workspace
    ├── Key Vault: kv-azinfra-dev
    │   ├── Network locked to AKS subnet only
    │   └── AKS managed identity has read access
    └── ACR: acrazinfradev
        └── AKS has AcrPull role assigned
```

---

## CI/CD Pipeline

GitHub Actions runs automatically on every push and pull request:

| Job | Trigger | What it does |
|-----|---------|-------------|
| terraform-validate | Every push + PR | Checks formatting and validates code |
| terraform-plan | Pull requests only | Runs plan and posts output as PR comment |
| terraform-security | Every push + PR | Scans for security issues with Checkov |

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.8.3
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription ([free tier](https://azure.microsoft.com/free))

---

## Quick Start

**1. Clone the repo:**

```bash
git clone https://github.com/amithvr46/azure-infrastructure-terraform.git
cd azure-infrastructure-terraform
```

**2. Login to Azure:**

```bash
az login
```

**3. Initialize Terraform:**

```bash
terraform init
```

**4. Preview what will be deployed:**

```bash
terraform plan
```

**5. Deploy:**

```bash
terraform apply
```

**6. Destroy when done to avoid charges:**

```bash
terraform destroy
```

---

## Project Structure

```
azure-infrastructure-terraform/
├── .github/
│   └── workflows/
│       └── terraform.yml    # CI/CD pipeline
├── modules/
│   ├── vnet/                # Virtual Network module
│   ├── aks/                 # AKS Cluster module
│   ├── keyvault/            # Key Vault module
│   └── acr/                 # Container Registry module
├── environments/
│   ├── dev/                 # Dev environment config
│   └── prod/                # Prod environment config
├── ansible/                 # VM baseline configuration
├── main.tf                  # Root module — wires everything together
├── variables.tf             # Input variables
├── outputs.tf               # Output values
└── .gitignore
```

---

## Key Design Decisions

**Modular structure** — Each Azure service is a separate reusable
module. Any team can call these modules to provision compliant
environments without writing Terraform from scratch.

**Security by default** — Key Vault is network-locked to the AKS
subnet. No public access. AKS uses managed identity — no hardcoded
credentials anywhere.

**Autoscaling** — AKS node pool scales between 1 and 5 nodes
automatically based on workload demand.

**Tagging** — All resources tagged with environment, project, owner,
and managed-by for cost tracking and compliance.

---

## Real World Context

This project mirrors the infrastructure patterns used at
Wells Fargo and Fidelity Investments — reusable Terraform
modules, managed identities instead of service principals,
Key Vault network restrictions, and AKS with proper monitoring.

At Wells Fargo, the same pattern reduced infrastructure
provisioning time from days to under an hour.

---

## Related Project

See also: [ai-devops-platform](https://github.com/amithvr46/ai-devops-platform)
— AI-powered DevOps tools built to work with this infrastructure.

---

## Author

**Amith Busireddy** — Cloud DevOps Engineer
- Email: Amithvr46@gmail.com
- LinkedIn: https://linkedin.com/in/busireddy-amith-761311181
- GitHub: https://github.com/amithvr46
