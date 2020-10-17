output "iothub_name" {
    description = "IoT Hub name to be used in az cli command parameters"
    value = module.iothub.iothub_name
}

output "iothubowner_connection_string" {
    description = "iothubowner connection string"
    value = module.iothub.iothubowner_connection_string
}

output "message_container_id" {
    description = "ID of the storage container where D2C messages are archived"
    value = module.iothub.message_container_id
}

output "file_container_id" {
    description = "ID of the storage container where IoT Hub file uploads are archived"
    value = module.iothub.file_container_id
}