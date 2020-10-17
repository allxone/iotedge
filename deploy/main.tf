provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "iothub" {
  name      = "${var.azure_prefix}_resource_group"
  location  = var.azure_location
}

# Creates core IoT Hub resources
module "iothub" {
  source                  = "./modules/iothub"
  name                    = "${var.azure_prefix}iothub"
  azurerm_resource_group  = azurerm_resource_group.iothub
}

# Creates IoT Hub monitoring resources
module "iothubdiag" {
  source                  = "./modules/iothub-monitoring"
  name                    = "${var.azure_prefix}iothubdiag"
  azurerm_resource_group  = azurerm_resource_group.iothub
  azurerm_iohub_id        = module.iothub.iothub_id
}

# # Creates IoT Hub Deployment Provisioning Services resources
# module "iothubdps" {
#   source                        = "./modules/iothub-dps"
#   name                          = "${var.azure_prefix}iothubmon"
#   azurerm_resource_group        = azurerm_resource_group.iothub
#   linked_hub_connection_string  = module.iothub.iothubowner_connection_string
# }