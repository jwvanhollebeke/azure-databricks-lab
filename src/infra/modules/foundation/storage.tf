
resource "azurerm_storage_account" "storage" {
  name                     = replace("jwvh${local.prefix}-${var.environment}", "-", "")
  resource_group_name      = azurerm_resource_group.lab.name
  location                 = azurerm_resource_group.lab.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    env = var.environment
  }
}

resource "azurerm_storage_container" "commonfiles" {
  name                  = "commonfiles"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "sales_csv" {
  name                   = "sales.csv"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.commonfiles.name
  type                   = "Block"
  source                 = "${path.module}/resources/sales.csv"
}
