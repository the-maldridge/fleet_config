terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.85.2"
    }
  }
}

provider "routeros" {
  hosturl = "https://172.16.31.1"
}
