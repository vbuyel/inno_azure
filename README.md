# inno_azure

Минимальный практический проект для знакомства с Azure через Terraform, Portal и Azure CLI.

```text
inno_azure/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   └── terraform.tfvars.example
├── python/
└── README.md
```

## План практики

1. **Создать Azure Account** — зарегистрируйтесь на [portal.azure.com](https://portal.azure.com) и установите Azure CLI (`brew install azure-cli`).
2. **Subscription и Resource Group** — выполните `az login`, получите ID подписки (`az account show --query id -o tsv`). Resource Group `rg-practice-1` создаётся в `terraform/main.tf`.
3. **Storage Account и Virtual Machine** — скопируйте `terraform/terraform.tfvars.example` в `terraform/terraform.tfvars`, заполните значения и разверните стек:
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```
4. **Посмотреть ресурсы в Portal** — откройте **Resource groups** → `rg-practice-1`, изучите **Resource visualizer** и **JSON View**.
5. **Основные команды Azure CLI**:
   ```bash
   az account list -o table
   az group list -o table
   az resource list --resource-group rg-practice-1 -o table
   az storage account list --resource-group rg-practice-1 -o table
   az vm list -d --resource-group rg-practice-1 -o table
   ```
6. **Изучить Cost Management** — откройте **Cost Management + Billing** → **Cost analysis**, отфильтруйте по `rg-practice-1`.
7. **Удалить ресурсы и проверить прекращение начислений**:
   ```bash
   terraform destroy
   az group exists --name rg-practice-1
   ```
   Убедитесь в Portal, что `rg-practice-1` удалена и дневные начисления перестали расти.
