terraform {
  required_version = ">= 1.0.0"

  # backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.58.0"
    }
    dynatrace = {
      source  = "dynatrace-oss/dynatrace"
      version = "1.2.2"
    }
  }
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "azurerm" {
  alias = "dcd-cnp-dev"
  skip_provider_registration = true
  features {}
  subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
}

provider "azurerm" {
  alias = "dcd-cnp-prod"
  skip_provider_registration = true
  features {}
  subscription_id = "8999dec3-0104-4a27-94ee-6588559729d1"
}

provider "dynatrace" {
  dt_env_url   = "https://${var.dynatrace_environment_id}.live.dynatrace.com"
  dt_api_token = data.azurerm_key_vault_secret.dynatrace_api_token.value
}