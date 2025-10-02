# terraform {
#   required_version = ">= 1.6.0"

#   backend "azurerm" {
#     resource_group_name  = "pixies-rg"                
#     storage_account_name = "lzaterraform"   
#     container_name       = "tfstate"                   
#     key                  = "subscription/prod/terraform.tfstate"
#     use_azuread_auth     = true                       
#   }
# }

terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" }
    azuread = { source = "hashicorp/azuread",  version = "~> 3.0" }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "8d27f4fa-3c4c-4136-852f-96b5d73cc242"
  tenant_id       = "f7a1853e-ee19-4fdc-b990-46a83c91d8e2"
}

provider "azuread" {
  tenant_id = "f7a1853e-ee19-4fdc-b990-46a83c91d8e2"
}

data "azurerm_billing_mca_account_scope" "cafanwii" {
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
}


## Adding optput. Don't use this for prod environment
## This is simply to output the IDs for this tutorial
data "azurerm_subscription" "current" {}



