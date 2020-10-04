output "iothubname" {
    description = ""
    value = azurerm_iothub.iothub.name
}

output "iothubowner_connection_string" {
    description = "iothubowner connection string"
    value = "HostName=${azurerm_iothub.iothub.hostname};SharedAccessKeyName=${azurerm_iothub.iothub.shared_access_policy[0].key_name};SharedAccessKey=${azurerm_iothub.iothub.shared_access_policy[0].primary_key}"
}

output "endpoint_connection_strings" {
    description = ""
    value = azurerm_iothub.iothub.endpoint[*].connection_string
}