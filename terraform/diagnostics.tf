resource "azurerm_log_analytics_workspace" "iothub" {
  name                = "${var.azure_prefix}loganalyticsws"
  location            = azurerm_resource_group.iothub.location
  resource_group_name = azurerm_resource_group.iothub.name
  sku                 = "Free"
  retention_in_days   = 7
}

resource "azurerm_monitor_diagnostic_setting" "iothub" {
  name               = "iothub"
  target_resource_id = azurerm_iothub.iothub.id
  storage_account_id = azurerm_storage_account.iothub.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.iothub.id
  log_analytics_destination_type = "Dedicated"

  log {
    category = "Connections"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "C2DCommands"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "DeviceIdentityOperations"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Routes"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "DeviceTelemetry"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "FileUploadOperations"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "C2DTwinOperations"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "D2CTwinOperations"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "TwinQueries"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "JobsOperations"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "DirectMethods"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "DistributedTracing"
    enabled  = false    # preview support only for North Europe, Southeast Asia, West US 2

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "Configurations"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "DeviceStreams"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

