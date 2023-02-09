# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.41.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "formation"
    storage_account_name = "jwvhdblabformation"
    container_name       = "tfstate"
    key                  = "lab.cluster.tfstate"
  }

  required_version = ">= 1.3.7"
}

provider "azurerm" {
  features {}
}

module "cluster" {
  source      = "../../modules/cluster"
  environment = "lab"
}