data "azurerm_key_vault" "devops_key_vault" {
  provider            = azurerm.devops-kv
  name                = var.devops_key_vault
  resource_group_name = var.devops_key_vault_rg
}

data "azurerm_key_vault_secret" "dynatrace_api_token" {
  name         = "dynatrace-nonprod-api-key"
  key_vault_id = data.azurerm_key_vault.devops_key_vault.id
}