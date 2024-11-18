resource "routeros_interface_bridge" "br0" {
  name           = "br0"
  vlan_filtering = true
  frame_types    = "admit-only-vlan-tagged"
}

resource "routeros_interface_vlan" "vlan" {
  for_each = {
    lan0  = { id = 10, description = "Local Network" }
    wan0  = { id = 20, description = "Upstream Networks" }
    mgmt0 = { id = 30, description = "Management Network" }
    peer0 = { id = 101, description = "Peer Networks" }
    gate0 = { id = 112, description = "Stargate" }
  }

  interface = routeros_interface_bridge.br0.name
  name      = each.key
  comment   = each.value.description
  vlan_id   = each.value.id
}

resource "routeros_interface_bridge_vlan" "br_vlan" {
  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [for s in sort(formatlist("%03d", [for vlan in routeros_interface_vlan.vlan : vlan.vlan_id])) : tonumber(s)]
  tagged   = [routeros_interface_bridge.br0.name]
  comment  = "Bridge Networks"
}

resource "routeros_interface_bridge_port" "vlan" {
  for_each = routeros_interface_vlan.vlan

  interface = each.value.name
  pvid      = each.value.vlan_id
  bridge    = routeros_interface_bridge.br0.name
  comment   = each.value.comment
}

resource "routeros_ip_address" "local" {
  for_each = var.subnets

  address   = format("%s/%d", cidrhost(each.value, 1), split("/", each.value)[1])
  interface = routeros_interface_vlan.vlan[format("%s0", each.key)].name
}

resource "routeros_ip_address" "peer" {
  address   = var.peer_address
  interface = routeros_interface_vlan.vlan["peer0"].name
}

resource "routeros_ip_address" "gate" {
  address   = "169.254.250.2/30"
  interface = routeros_interface_vlan.vlan["gate0"].name
}
