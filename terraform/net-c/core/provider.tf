terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.1"
    }
    macaddress = {
      source  = "ivoronin/macaddress"
      version = "0.3.2"
    }
  }

  backend "http" {
    address        = "http://172.16.35.5:3030/state/prod/net-c"
    lock_address   = "http://172.16.35.5:3030/state/prod/net-c"
    unlock_address = "http://172.16.35.5:3030/state/prod/net-c"
  }
}

provider "routeros" {
  hosturl = "https://172.16.35.1"
}
