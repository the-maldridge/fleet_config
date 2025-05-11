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

resource "routeros_interface_bridge_port" "bond" {
  for_each = var.bonds

  bridge    = routeros_interface_bridge.br0.name
  interface = each.key
  pvid      = 1
}

resource "routeros_interface_bonding" "bond" {
  for_each = var.bonds

  name   = each.key
  slaves = each.value
  mode   = "802.3ad"
}
