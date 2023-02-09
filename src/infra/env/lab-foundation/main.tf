# Configure the Azure provider
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

  backend "azurerm" {
    resource_group_name  = "formation"
    storage_account_name = "jwvhdblabformation"
    container_name       = "tfstate"
    key                  = "lab.tfstate"
  }

  required_version = ">= 1.3.7"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

module "foundation" {
  source      = "../../modules/foundation"
  environment = "lab"
}