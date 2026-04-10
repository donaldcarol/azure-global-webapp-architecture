terraform {

  backend "azurerm" {

    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstatefitzai"
    container_name       = "tfstate"
    key                  = "foundation.tfstate"

  }

}