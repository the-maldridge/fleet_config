resource "routeros_interface_bridge" "br0" {
  name           = "br0"
  vlan_filtering = true
  frame_types    = "admit-only-vlan-tagged"
}

resource "routeros_interface_vlan" "vlan" {
  for_each = {
    lan0   = { id = 10, description = "Local Network" }
    trust0 = { id = 15, description = "Trusted Network" }
    wan0   = { id = 20, description = "Default Upstream" }
    media0 = { id = 25, description = "Media Network" }
    mgmt0  = { id = 30, description = "Management Network" }
    peer0  = { id = 101, description = "Peer Networks" }
    gate0  = { id = 112, description = "Stargate" }
  }

  interface = routeros_interface_bridge.br0.name
  name      = each.key
  comment   = each.value.description
  vlan_id   = each.value.id
}

resource "routeros_interface_bridge_vlan" "br_vlan" {
  for_each = routeros_interface_vlan.vlan

  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [tonumber(each.value.vlan_id)]
  tagged   = flatten([routeros_interface_bridge.br0.name, var.trunks, keys(var.bonds)])
  untagged = lookup(var.ports, replace(each.key, "0", ""), [])
  comment  = each.value.comment
}

resource "routeros_interface_list" "local" {
  name = "local"
}

resource "routeros_interface_list_member" "local" {
  for_each = { for iface, val in routeros_interface_vlan.vlan : iface => val if iface != "wan0" }

  list      = routeros_interface_list.local.name
  interface = routeros_interface_vlan.vlan[each.key].name
}

resource "routeros_interface_list" "trusted_origin" {
  name = "trusted_origin"
}

resource "routeros_interface_list_member" "trusted_origin" {
  for_each = { for iface, val in routeros_interface_vlan.vlan : iface => val if contains(["peer0", "mgmt0", "media0", "gate0"], iface) }

  list      = routeros_interface_list.trusted_origin.name
  interface = routeros_interface_vlan.vlan[each.key].name
}

resource "routeros_interface_list" "untrusted_origin" {
  name = "untrusted_origin"
}

resource "routeros_interface_list_member" "untrusted_origin" {
  # This looks wrong, but the trust0 network really is untrusted.
  # That's for entities that should be allowed broader network access
  # to the outside, but not necessarily any more access to the actual
  # local network.
  for_each = { for iface, val in routeros_interface_vlan.vlan : iface => val if contains(["trust0", "lan0"], iface) }

  list      = routeros_interface_list.untrusted_origin.name
  interface = routeros_interface_vlan.vlan[each.key].name
}

resource "routeros_interface_list" "upstreams" {
  name = "upstreams"
}

resource "routeros_interface_vlan" "upstream" {
  for_each = var.additional_upstreams

  interface = routeros_interface_bridge.br0.name
  name      = each.key
  comment   = each.value.description
  vlan_id   = each.value.id
}

resource "routeros_interface_list_member" "default_upstream" {
  list      = routeros_interface_list.upstreams.name
  interface = routeros_interface_vlan.vlan["wan0"].name
}

resource "routeros_interface_bridge_vlan" "upstream_vlan" {
  for_each = routeros_interface_vlan.upstream

  bridge   = routeros_interface_bridge.br0.name
  vlan_ids = [tonumber(each.value.vlan_id)]
  tagged   = flatten([routeros_interface_bridge.br0.name, var.trunks, keys(var.bonds)])
  untagged = lookup(var.ports, replace(each.key, "0", ""), [])
  comment  = each.value.comment
}

resource "routeros_interface_list_member" "supplemental_upstream" {
  for_each = routeros_interface_vlan.upstream

  list      = routeros_interface_list.upstreams.name
  interface = each.value.name
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
