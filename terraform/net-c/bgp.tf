resource "routeros_routing_bgp_instance" "adjacent" {
  as         = 64579
  name       = "Adjacent"
  comment    = "Adjacent Peers"
  cluster_id = "169.254.255.1"
  router_id  = "169.254.255.9"
}

resource "routeros_routing_bgp_connection" "adjacent" {
  for_each = {
    p0rtalNet-core = { asn = 64579, addr = "169.254.255.1" }

    bag-bcm   = { asn = 64582, addr = "169.254.255.4" }
    sneakynet = { asn = 64582, addr = "169.254.255.6" }
    minitel   = { asn = 64582, addr = "169.254.255.7" }
    net-a     = { asn = 64582, addr = "169.254.255.8" }
    net-b     = { asn = 64582, addr = "169.254.255.5" }
  }

  as       = 64582
  name     = each.key
  instance = routeros_routing_bgp_instance.adjacent.name

  connect        = true
  listen         = true
  nexthop_choice = "force-self"


  hold_time      = "30s"
  keepalive_time = "10s"

  local {
    role    = each.value.asn == 64582 ? "ibgp" : "ebgp"
    address = "169.254.255.9"
  }

  remote {
    address = each.value.addr
    as      = each.value.asn
  }

  output {
    default_originate = "if-installed"
    redistribute      = "connected,bgp"
    network           = "local"
  }
}
