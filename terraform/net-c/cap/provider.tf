terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }


  backend "http" {
    address        = "http://172.16.35.5:3030/state/prod/net-c-cap"
    lock_address   = "http://172.16.35.5:3030/state/prod/net-c-cap"
    unlock_address = "http://172.16.35.5:3030/state/prod/net-c-cap"
  }
}

provider "routeros" {}
