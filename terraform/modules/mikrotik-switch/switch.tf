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
  bridge = routeros_interface_bridge.br0.name
  vlan_ids = [for s in sort(formatlist("%03d",
    flatten([routeros_interface_vlan.mgmt.vlan_id, values(var.vlans)]
  ))) : tonumber(s)]
  tagged  = flatten([routeros_interface_bridge.br0.name, var.trunks])
  comment = "Bridge Networks"
}

resource "routeros_interface_bridge_port" "physical" {
  for_each = transpose(var.ports)

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = var.vlans[one(each.value)]
}

resource "routeros_interface_bridge_port" "trunk" {
  for_each = var.trunks

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = 1
}

resource "routeros_interface_bridge_vlan" "vlan" {
  for_each = var.ports

  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [var.vlans[each.key]]
  untagged = each.value
}
