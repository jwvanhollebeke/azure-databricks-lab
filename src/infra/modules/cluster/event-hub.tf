// Integration with event hub -- uncomment if needed

/*
resource "azurerm_eventhub_namespace" "ns" {
  name                = "learn-databricks-ns-${var.environment}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Basic"
  capacity            = 1

  tags = {
    environment = var.environment
  }
}

resource "azurerm_eventhub" "example" {
  name                = "learn-databricks-${var.environment}"
  namespace_name      = azurerm_eventhub_namespace.ns.name
  resource_group_name = data.azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "read_write" {
  name                = "read_and_write_events"
  resource_group_name = data.azurerm_resource_group.rg.name
  namespace_name      = azurerm_eventhub_namespace.ns.name
  eventhub_name       = azurerm_eventhub.example.name
  listen              = true
  send                = true
  manage              = false
}
*/
