output "iothub_name" {
    description = "IoT Hub name to be used in az cli command parameters"
    value = azurerm_iothub.iothub.name
}

output "iothub_id" {
    description = "IoT Hub resource ID"
    value = azurerm_iothub.iothub.id
}

output "iothubowner_connection_string" {
    description = "iothubowner connection string"
    value = "HostName=${azurerm_iothub.iothub.hostname};SharedAccessKeyName=${azurerm_iothub.iothub.shared_access_policy[0].key_name};SharedAccessKey=${azurerm_iothub.iothub.shared_access_policy[0].primary_key}"
}

output "message_container_id" {
    description = "ID of the storage container where D2C messages are archived"
    value = azurerm_storage_container.messagecontainer.id
}

output "file_container_id" {
    description = "ID of the storage container where IoT Hub file uploads are archived"
    value = azurerm_storage_container.filecontainer.id
}