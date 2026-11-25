# inno_azure

Minimal Azure data platform project structure using Terraform and a Medallion architecture (`bronze` / `silver` / `gold`).

```text
inno_azure/
├── infrastructure/
│   ├── modules/
│   │   ├── resource-group/
│   │   ├── storage/
│   │   ├── identity/
│   │   └── monitoring/
│   └── environments/
│       ├── dev/
│       └── prod/
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
