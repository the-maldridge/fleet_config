data "routeros_interfaces" "ether1" {
  filter = {
    name = "ether1"
  }
}

data "routeros_interfaces" "sfp1" {
  filter = {
    name = "sfp1"
  }
}

resource "routeros_interface_bridge" "br0" {
  name              = "br0"
  frame_types       = "admit-only-vlan-tagged"
  vlan_filtering    = true
  ingress_filtering = true
  auto_mac          = false
  admin_mac         = data.routeros_interfaces.ether1.interfaces[0].mac_address
}

resource "routeros_interface_vlan" "vlan" {
  for_each = {
    lan   = 10
    trust = 15
    media = 25
    mgmt  = 30
  }

  name      = each.key
  interface = routeros_interface_bridge.br0.name
  vlan_id   = each.value
  comment   = each.key
}

resource "routeros_interface_bridge_vlan" "br_internal" {
  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [for vlan in routeros_interface_vlan.vlan : vlan.vlan_id]
  tagged = flatten([
    [routeros_interface_bridge.br0.name],
    [for iface in routeros_interface_bridge_port.ports : iface.interface]
  ])
}

resource "routeros_interface_bridge_port" "ports" {
  for_each = toset(flatten([
    ["ether1"],
    length(data.routeros_interfaces.sfp1.interfaces)>0 ? ["sfp1"] : [],
  ]))

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = 1
}

resource "routeros_ip_dhcp_client" "upstream" {
  interface         = routeros_interface_vlan.vlan["mgmt"].name
  add_default_route = "yes"
  use_peer_ntp      = true
  use_peer_dns      = true
  comment           = "Internal Upstream"
}
