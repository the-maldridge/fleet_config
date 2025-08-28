terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }

  backend "http" {
    address        = "http://172.16.34.3:8085/state/prod/skylink"
    lock_address   = "http://172.16.34.3:8085/state/prod/skylink"
    unlock_address = "http://172.16.34.3:8085/state/prod/skylink"
  }
}

provider "routeros" {
  hosturl = "https://172.16.34.17"
}

variable "net_config" {
  type = object({
    ssid = string
    psk  = string
    mode = optional(string, "WPA")
    band = optional(string, "2ghz-g/n")
  })
  default = {
    ssid = "NONENET1"
    psk  = "NONEPASS"
  }
  description = "Wireless network config"
}

module "downlink" {
  source = "../modules/mikrotik-downlink"

  hostname = "skynet1"

  network_ssid          = var.net_config.ssid
  network_psk           = var.net_config.psk
  network_security_mode = var.net_config.mode
  network_band          = var.net_config.band
}
