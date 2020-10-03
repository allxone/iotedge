output "iothubname" {
    description = ""
    value = azurerm_iothub.iothub.name
}

output "endpoint_connection_strings" {
    description = ""
    value = azurerm_iothub.iothub.endpoint[*].connection_string
}