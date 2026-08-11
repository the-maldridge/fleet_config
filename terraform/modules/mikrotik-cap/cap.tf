resource "routeros_wifi_cap" "settings" {
  caps_man_addresses = [var.capsman_address]
  enabled            = true
  slaves_datapath    = routeros_wifi_datapath.datapath.name
}

resource "routeros_wifi_datapath" "datapath" {
  name   = "capdp"
  bridge = routeros_interface_bridge.br0.name
}

data "routeros_interfaces" "wifi" {
  filter = {
    type = "wifi"
  }
}

import {
  for_each = toset(["wifi1", "wifi2"])

  to = routeros_wifi.wifi[each.key]
  id = one([for intf in data.routeros_interfaces.wifi.interfaces : intf.id if intf.name == each.key])
}

resource "routeros_wifi" "wifi" {
  for_each = toset(["wifi1", "wifi2"])

  configuration = {
    manager = "capsman-or-local"
    country = "United States"
  }
  name = each.key
  datapath = {
    config = routeros_wifi_datapath.datapath.name
  }
  disabled = false
}
