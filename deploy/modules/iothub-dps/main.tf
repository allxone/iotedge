resource "azurerm_iothub_dps" "iothub" {
  name                = "${var.name}dps"
  resource_group_name = var.azurerm_resource_group.name
  location            = var.azurerm_resource_group.location

  sku {
    name     = "S1"
    capacity = "1"
  }

  linked_hub {
    connection_string = var.linked_hub_connection_string
    location          = var.azurerm_resource_group.location
  }
}