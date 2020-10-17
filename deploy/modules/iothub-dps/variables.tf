variable "name" {
    description = "Resource name prefix"
}

variable "azurerm_resource_group" {
    type = object({
        # Declare an object using only the subset of attributes the module
        # needs. Terraform will allow any object that has at least these
        # attributes.
        name = string
        location = string
    })
    description = "Parent resource group object"
}

variable "linked_hub_connection_string" {
    description = "Linked IoT Hub connection string"
}