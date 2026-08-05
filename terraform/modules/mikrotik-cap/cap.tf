resource "routeros_wifi_cap" "settings" {
  caps_man_addresses = [var.capsman_address]
  enabled            = true
  slaves_datapath    = routeros_wifi_datapath.datapath.name
}

resource "routeros_wifi_datapath" "datapath" {
  name   = "capdp"
  bridge = routeros_interface_bridge.br0.name
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
