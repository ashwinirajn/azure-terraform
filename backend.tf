terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstate1409282651"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}