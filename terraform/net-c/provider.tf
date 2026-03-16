terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.1"
    }
  }
}

provider "routeros" {
  hosturl = "https://172.16.35.1"
}
