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

variable "azurerm_iothub_sku" {
    default = "F1"    # F1 grants access to max 1 endpoint
}

variable "azurerm_iothub_capacity" {
    default = "1"
}

