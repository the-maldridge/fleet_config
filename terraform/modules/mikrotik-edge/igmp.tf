resource "routeros_interface_bridge" "igmp" {
  name     = "igmp-upstream"
  disabled = false
  comment  = "Dummy bridge to keep IGMP Proxy active"
}

resource "routeros_ip_address" "dummy_bridge_ip" {
  address   = "127.0.2.1/24"
  interface = routeros_interface_bridge.igmp.name
  disabled  = false
}

resource "routeros_routing_igmp_proxy_interface" "upstream" {
  interface = routeros_interface_bridge.igmp.name
  upstream  = true
}

resource "routeros_routing_igmp_proxy_interface" "igmp" {
  for_each = toset([for vlan, attrs in local.networks : vlan if lookup(attrs, "igmp", false)])

  interface = each.key
}
