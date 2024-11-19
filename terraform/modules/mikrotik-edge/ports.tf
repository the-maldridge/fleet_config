resource "routeros_interface_bridge_port" "physical" {
  for_each = transpose(var.ports)

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = routeros_interface_vlan.vlan[format("%s0", one(each.value))].vlan_id
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
  vlan_ids = [routeros_interface_vlan.vlan[format("%s0", each.key)].vlan_id]
  untagged = each.value
}
