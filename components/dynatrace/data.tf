data "azurerm_client_config" "current" {}

data "azurerm_key_vault_secret" "dynatrace_api_token" {
  name         = "dynatrace-api-key-dtspo2551"
  key_vault_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/genesis_resource_group/providers/Microsoft.KeyVault/vaults/${var.devops_key_vault}"
}