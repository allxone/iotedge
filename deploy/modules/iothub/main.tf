resource "azurerm_storage_account" "iothub" {
  name                     = "${var.name}sa"
  resource_group_name      = var.azurerm_resource_group.name
  location                 = var.azurerm_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"   # hns can't be used as a target for diagnostic settings
}

resource "azurerm_storage_container" "messagecontainer" {
  name                  = "${var.name}messagecontainer"
  storage_account_name  = azurerm_storage_account.iothub.name
  container_access_type = "private"

}

resource "azurerm_storage_container" "filecontainer" {
  name                  = "${var.name}filecontainer"
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
  name                = var.name
  resource_group_name = var.azurerm_resource_group.name
  location            = var.azurerm_resource_group.location

  sku {
    name      = var.azurerm_iothub_sku 
    capacity  = var.azurerm_iothub_capacity
  }

  endpoint {
    type                       = "AzureIotHub.StorageContainer"
    connection_string          = azurerm_storage_account.iothub.primary_blob_connection_string
    name                       = "export"
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    container_name             = azurerm_storage_container.messagecontainer.name
    encoding                   = "Avro"
    file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
  }

  # endpoint {
  #   type              = "AzureIotHub.EventHub"
  #   connection_string = azurerm_eventhub_authorization_rule.iothub.primary_connection_string
  #   name              = "export2"
  # }

  file_upload {
    connection_string = azurerm_storage_account.iothub.primary_blob_connection_string
    container_name    = azurerm_storage_container.filecontainer.name
  }

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
}