# inno_azure

Minimal Azure data platform project structure using Terraform and a Medallion architecture (`bronze` / `silver` / `gold`).

```text
inno_azure/
├── AGENTS.md
├── infrastructure/
│   ├── modules/
│   │   ├── resource-group/
│   │   ├── storage/
│   │   ├── identity/
│   │   └── monitoring/
│   └── environments/
│       ├── dev/
│       ├── mock/
│       └── prod/
├── scripts/
│   └── mock-az.sh
├── ingestion/
│   ├── api/
│   ├── database/
│   └── files/
├── processing/
│   ├── bronze/
│   ├── silver/
│   └── gold/
├── orchestration/
├── warehouse/
├── tests/
├── monitoring/
├── .github/workflows/
└── README.md
```

## Quick Start (Terraform)

```bash
cd infrastructure/environments/dev
terraform init
terraform plan -var="subscription_id=<SUBSCRIPTION_ID>" -var="storage_account_name=<UNIQUE_NAME>"
terraform apply -var="subscription_id=<SUBSCRIPTION_ID>" -var="storage_account_name=<UNIQUE_NAME>"
```

## Mock Mode (Local Testing without Azure Subscription)

When no active Azure subscription or network access to Azure API is available (see [AGENTS.md](AGENTS.md)), use the local mock environment:

### Terraform Mock (`terraform_data`)

```bash
cd infrastructure/environments/mock
terraform init
terraform apply -auto-approve
terraform output
terraform plan -var="location=northeurope"
terraform destroy -auto-approve
```

### Azure CLI Mock (`scripts/mock-az.sh`)

```bash
./scripts/mock-az.sh account show
./scripts/mock-az.sh group create --name rg-inno-mock-cli --location westeurope
./scripts/mock-az.sh group show --name rg-inno-mock-cli
./scripts/mock-az.sh group delete --name rg-inno-mock-cli --yes
```
