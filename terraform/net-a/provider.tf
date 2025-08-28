terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }

  backend "http" {
    address = "http://172.16.34.3:8085/state/prod/net-a"
    lock_address = "http://172.16.34.3:8085/state/prod/net-a"
    unlock_address = "http://172.16.34.3:8085/state/prod/net-a"
  }
}

provider "routeros" {
  hosturl = "https://172.16.34.1"
}
