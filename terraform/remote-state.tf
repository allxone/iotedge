terraform {
  backend "remote" {
    organization = "Stedel"

    workspaces {
      name = "iothub"
    }
  }
}