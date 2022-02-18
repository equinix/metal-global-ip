terraform {
  required_providers {
    metal = {
      source = "equinix/metal"
      version = "3.2.1"
    }
  }
}

provider "metal" {
  auth_token = var.metal_token
}
