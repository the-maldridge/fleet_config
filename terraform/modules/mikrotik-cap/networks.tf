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

locals {
  uplinks = toset(concat(
    ["ether1"],
    length(data.routeros_interfaces.sfp1.interfaces) > 0 ? ["sfp1"] : [],
  ))

  # VLANs that also get a routed (L3) interface on the CAP
  named_vlans = {
    lan   = 10
    trust = 15
    media = 25
    mgmt  = 30
  }

  # Every VLAN id that switch ports want to carry
  requested_vlans = toset(flatten([
    for p in var.switch_ports : p.untagged != null ? concat(p.tagged, [p.untagged]) : p.tagged
  ]))

  # All VLANs present in the bridge VLAN table. RouterOS allows a VLAN id in
  # only one static row, so each VLAN gets its own row and arbitrary extra
  # VLANs are named after their id.
  all_vlans = merge(
    local.named_vlans,
    {
      for vid in setsubtract(local.requested_vlans, toset(values(local.named_vlans))) :
      "vlan${vid}" => vid
    }
  )

  # Uplinks trunk every VLAN; the bridge itself is tagged only where it has an
  # L3 interface for the VLAN.
  tagged_ports = {
    for name, vid in local.all_vlans :
    name => concat(
      contains(keys(local.named_vlans), name) ? [routeros_interface_bridge.br0.name] : [],
      tolist(local.uplinks),
      [for name, p in var.switch_ports : name if contains(p.tagged, vid)],
    )
  }

  untagged_ports = {
    for name, vid in local.all_vlans :
    name => [
      for name, p in var.switch_ports : name if p.untagged == vid
    ]
  }

  # Access ports convert their native VLAN, trunk-only ports admit tagged
  # frames only, hybrid ports do both.
  switch_port_config = {
    for name, p in var.switch_ports : name => {
      frame_types = p.untagged == null ? "admit-only-vlan-tagged" : (
        length(p.tagged) > 0 ? "admit-all" : "admit-only-untagged-and-priority-tagged"
      )
      pvid = coalesce(p.untagged, 1)
    }
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
  for_each = local.named_vlans

  name      = each.key
  interface = routeros_interface_bridge.br0.name
  vlan_id   = each.value
  comment   = each.key
}

resource "routeros_interface_bridge_vlan" "br_internal" {
  for_each = local.all_vlans

  bridge     = routeros_interface_bridge.br0.name
  vlan_ids   = [each.value]
  tagged     = local.tagged_ports[each.key]
  untagged   = local.untagged_ports[each.key]
  depends_on = [routeros_interface_bridge_port.ports]
}

resource "routeros_interface_bridge_port" "ports" {
  for_each = merge(
    {
      for iface in local.uplinks :
      iface => {
        frame_types = null
        pvid        = 1
      }
    },
    local.switch_port_config
  )

  bridge      = routeros_interface_bridge.br0.name
  interface   = each.key
  frame_types = each.value.frame_types
  pvid        = each.value.pvid
}

resource "routeros_ip_dhcp_client" "upstream" {
  interface         = routeros_interface_vlan.vlan["mgmt"].name
  add_default_route = "yes"
  use_peer_ntp      = true
  use_peer_dns      = true
  comment           = "Internal Upstream"
}
