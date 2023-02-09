resource "azurerm_monitor_action_group" "databricks" {
  name                = "${azurerm_resource_group.lab.name}-monitor"
  resource_group_name = azurerm_resource_group.lab.name
  short_name          = var.environment
}

resource "azurerm_consumption_budget_resource_group" "databricks_budget" {
  name              = "${azurerm_resource_group.lab.name}-budget"
  resource_group_id = azurerm_resource_group.lab.id

  amount     = 50
  time_grain = "Monthly"

  time_period {
    start_date = "2023-02-01T00:00:00Z"
  }

  notification {
    threshold      = 10.0
    operator       = "GreaterThanOrEqualTo"
    threshold_type = "Forecasted"

    contact_emails = [
      "jwvanhollebeke@gmail.com"
    ]
  }

  notification {
    threshold      = 90.0
    operator       = "GreaterThanOrEqualTo"
    threshold_type = "Forecasted"

    contact_emails = [
      "jwvanhollebeke@gmail.com"
    ]
  }

  notification {
    threshold = 100.0
    operator  = "GreaterThan"

    contact_emails = [
      "jwvanhollebeke@gmail.com"
    ]
  }
}
