
terraform {
  required_providers {
    btp = {
      source  = "sap/btp"
      version = "~>1.1.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg_terraform_state_sapbtp"
    storage_account_name = "sasapbtptfstate"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }

}

# Please checkout documentation on how best to authenticate against SAP BTP
# via the Terraform provider for SAP BTP
provider "btp" {
  globalaccount = var.globalaccount
}
