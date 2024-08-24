resource "routeros_interface_bridge_port" "lan" {
  for_each = var.ports.lan

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = routeros_interface_vlan.vlan["lan0"].vlan_id
}

resource "routeros_interface_bridge_vlan" "lan" {
  for_each = var.ports.lan

  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [routeros_interface_vlan.vlan["lan0"].vlan_id]
  untagged = [each.key]
}

resource "routeros_interface_bridge_port" "wan" {
  for_each = var.ports.wan

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = routeros_interface_vlan.vlan["wan0"].vlan_id
}

resource "routeros_interface_bridge_vlan" "wan" {
  for_each = var.ports.wan

  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [routeros_interface_vlan.vlan["wan0"].vlan_id]
  untagged = [each.key]
}

resource "routeros_interface_bridge_port" "peer" {
  for_each = var.ports.peer

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = routeros_interface_vlan.vlan["peer0"].vlan_id
}

resource "routeros_interface_bridge_vlan" "peer" {
  for_each = var.ports.peer

  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [routeros_interface_vlan.vlan["peer0"].vlan_id]
  untagged = [each.key]
}

resource "routeros_interface_bridge_port" "gate" {
  for_each = lookup(var.ports, "dhd", [])

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = routeros_interface_vlan.vlan["gate0"].vlan_id
}

resource "routeros_interface_bridge_vlan" "gate" {
  for_each = lookup(var.ports, "dhd", [])

  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [routeros_interface_vlan.vlan["gate0"].vlan_id]
  tagged   = [each.key]
}
