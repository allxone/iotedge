resource "azurerm_log_analytics_workspace" "iothub" {
  name                = "${var.name}loganalyticsws"
  location            = var.azurerm_resource_group.location
  resource_group_name = var.azurerm_resource_group.name
  sku                 = var.azurerm_log_analytics_workspace_sku
  retention_in_days   = var.azurerm_log_analytics_workspace_retention
}

# resource "azurerm_storage_account" "iothubdiag" {
#   name                     = "${var.azure_prefix}iothubdiagstorage"
#   resource_group_name      = var.azurerm_resource_group.name
#   location                 = var.azurerm_resource_group.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

resource "azurerm_monitor_diagnostic_setting" "iothub" {
  name                            = var.name
  target_resource_id              = var.azurerm_iohub_id
  # storage_account_id              = azurerm_storage_account.iothubdiag.id
  log_analytics_workspace_id      = azurerm_log_analytics_workspace.iothub.id
  log_analytics_destination_type  = "Dedicated"

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

