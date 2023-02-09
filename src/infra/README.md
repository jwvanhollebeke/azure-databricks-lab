# Databricks Infrastructure

Contains instructions and infrastructure-as-code for Azure Databricks lab.

## Getting started

Instructions:

1. Run `../utils/create-service-principal.sh` with your subscription id as the first positional
   parameter.
2. Set the following environment variables:

    ```bash
    export ARM_CLIENT_ID="<APPID_VALUE>"
    export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
    export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
    export ARM_TENANT_ID="<TENANT_VALUE>"
    ```

3. In the Azure Portal, create a resource group for your formational resources (storage account for
   terraform backend).
4. In the Azure Portal, create a storage account.
5. In the Azure Portal, create a container.
6. Update `env/lab/main.tf` to use your storage account and container.
7. Run `terraform apply`
