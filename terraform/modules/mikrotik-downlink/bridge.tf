resource "routeros_interface_bridge" "br0" {
  name           = "br0"
  vlan_filtering = true
  frame_types    = "admit-only-vlan-tagged"
}

resource "routeros_interface_vlan" "mgmt" {
  interface = routeros_interface_bridge.br0.name
  name      = "mgmt0"
  comment   = "Management Network"
  vlan_id   = 30
}

resource "routeros_ip_dhcp_client" "upstream" {
  interface         = routeros_interface_vlan.mgmt.name
  add_default_route = "yes"
  use_peer_ntp      = true
  use_peer_dns      = true
  comment           = "External Upstream"
}

resource "routeros_interface_bridge_vlan" "br_vlan" {
  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [30]
  tagged   = ["ether1"]
  comment  = "Management Network"
}

resource "routeros_interface_bridge_port" "ether1" {
  bridge    = routeros_interface_bridge.br0.name
  interface = "ether1"
  pvid      = 1
}

resource "routeros_interface_bridge_port" "wlan1" {
  bridge    = routeros_interface_bridge.br0.name
  interface = "wlan1"
  pvid      = var.downlink_vlan
}


// TEMPORARY

resource "routeros_interface_bridge_vlan" "tmp" {
  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [var.downlink_vlan]
  tagged   = ["ether1"]
  untagged = ["wlan1"]
}

resource "routeros_interface_vlan" "tmp" {
  interface = routeros_interface_bridge.br0.name
  name      = "tmp0"
  comment   = "Test Network"
  vlan_id   = var.downlink_vlan
}

resource "routeros_ip_dhcp_client" "tmp" {
  interface         = routeros_interface_vlan.tmp.name
  add_default_route = "no"
  use_peer_ntp      = false
  use_peer_dns      = false
}
