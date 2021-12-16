terraform {
  required_version = ">= 1.0.0"

  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.58.0"
    }
    dynatrace = {
      source  = "dynatrace-oss/dynatrace"
      version = "1.9.1"
    }
  }
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "azurerm" {
  alias                      = "devops-kv"
  skip_provider_registration = true
  features {}
  subscription_id = var.devops_key_vault_subscription_id
}

provider "dynatrace" {
  dt_env_url   = "https://${var.dynatrace_environment_id}.live.dynatrace.com"
  dt_api_token = data.azurerm_key_vault_secret.dynatrace_api_token.value
}