terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.41.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.33.0"
    }
  }
}

locals {
  prefix = "learn-databricks"
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "lab" {
  name     = "databricks-${var.environment}"
  location = var.region

  tags = {
    env = var.environment
  }
}
