
locals {
  vault_owners = toset([
    data.azurerm_client_config.current.object_id,
    "742b5bd9-36d5-427e-aa31-ac2ac07601b8"
  ])
}

resource "azurerm_key_vault" "vault" {
  name                        = "${local.prefix}-${var.environment}"
  location                    = azurerm_resource_group.lab.location
  resource_group_name         = azurerm_resource_group.lab.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "full_access" {
  for_each     = local.vault_owners
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "GetRotationPolicy",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Release",
    "Restore",
    "Rotate",
    "SetRotationPolicy",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",

  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}

# This value is not really a secret
resource "azurerm_key_vault_secret" "storageaccount" {
  name         = "storageaccount"
  value        = azurerm_storage_account.storage.name
  key_vault_id = azurerm_key_vault.vault.id

  # FIXME: unresolved cyclic depdendency, the DAG may delete the access policy first
  # which prevents `terraform destroy` from deleting the secret. Solutions include adjusting
  # the access policy, keeping this depends_on, provisioning secrets in the cluster module.
  depends_on = [
    azurerm_key_vault_access_policy.full_access
  ]
}

# SAS token secrets created manually
