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

variable "azurerm_iohub_id" {
    description = "IoT Hub resource id"
}

variable "azurerm_log_analytics_workspace_sku" {
    default = "free"
}

variable "azurerm_log_analytics_workspace_retention" {
    default = 7
}