resource "azurerm_resource_group" "iothub" {
  name     = "${var.azure_prefix}iothubresources"
  location = var.azure_location
}

resource "azurerm_storage_account" "iothub" {
  name                     = "${var.azure_prefix}iothubstorage"
  resource_group_name      = azurerm_resource_group.iothub.name
  location                 = azurerm_resource_group.iothub.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "iothub" {
  name                  = "${var.azure_prefix}iothubcontainer"
  storage_account_name  = azurerm_storage_account.iothub.name
  container_access_type = "private"
}

# resource "azurerm_eventhub_namespace" "iothub" {
#   name                = "${var.azure_prefix}iothubnamespace"
#   resource_group_name = azurerm_resource_group.iothub.name
#   location            = azurerm_resource_group.iothub.location
#   sku                 = "Basic"
# }

# resource "azurerm_eventhub" "iothub" {
#   name                = "${var.azure_prefix}iothubeventhub"
#   resource_group_name = azurerm_resource_group.iothub.name
#   namespace_name      = azurerm_eventhub_namespace.iothub.name
#   partition_count     = 2
#   message_retention   = 1
# }

# resource "azurerm_eventhub_authorization_rule" "iothub" {
#   resource_group_name = azurerm_resource_group.iothub.name
#   namespace_name      = azurerm_eventhub_namespace.iothub.name
#   eventhub_name       = azurerm_eventhub.iothub.name
#   name                = "acctest"
#   send                = true
# }

resource "azurerm_iothub" "iothub" {
  name                = "${var.azure_prefix}iothub"
  resource_group_name = azurerm_resource_group.iothub.name
  location            = azurerm_resource_group.iothub.location

  sku {
    name     = "F1" # F1 grants access to max 1 endpoint
    capacity = "1"
  }

  endpoint {
    type                       = "AzureIotHub.StorageContainer"
    connection_string          = azurerm_storage_account.iothub.primary_blob_connection_string
    name                       = "export"
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    container_name             = azurerm_storage_container.iothub.name
    encoding                   = "Avro"
    file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
  }

  # endpoint {
  #   type              = "AzureIotHub.EventHub"
  #   connection_string = azurerm_eventhub_authorization_rule.iothub.primary_connection_string
  #   name              = "export2"
  # }

  route {
    name           = "export"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export"]
    enabled        = true
  }

  # route {
  #   name           = "export2"
  #   source         = "DeviceMessages"
  #   condition      = "true"
  #   endpoint_names = ["export2"]
  #   enabled        = true
  # }

  tags = {
    purpose = "testing"
  }
}