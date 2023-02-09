terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.41.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = "1.0.0"
    }
  }
}

locals {
  prefix = "learn-databricks"
}

data "azurerm_resource_group" "rg" {
  name = "databricks-${var.environment}"
}

data "azurerm_databricks_workspace" "workspace" {
  name                = "learn-databricks-${var.environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_key_vault" "example" {
  name                = "${local.prefix}-${var.environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
}

provider "databricks" {
  host = data.azurerm_databricks_workspace.workspace.workspace_url
}
