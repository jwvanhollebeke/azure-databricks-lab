
resource "azurerm_data_factory" "factory" {
  name                = "learn-databricks-${var.environment}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_data_factory_linked_service_azure_databricks" "linked" {
  name                = "linked-service"
  data_factory_id     = azurerm_data_factory.factory.id
  description         = "Azure Databricks Linked Service via Access Token"
  existing_cluster_id = databricks_cluster.single_node.id
  access_token        = databricks_token.pat.token_value
  adb_domain          = "https://${data.azurerm_databricks_workspace.workspace.workspace_url}"
}
