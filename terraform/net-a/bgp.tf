resource "routeros_routing_bgp_connection" "docked" {
  as = 64582

  name           = "p0rtalNet-core"
  connect        = true
  listen         = true
  router_id      = "169.254.255.8"
  hold_time      = "30s"
  keepalive_time = "10s"
  nexthop_choice = "force-self"

  local {
    role    = "ebgp"
    address = "169.254.255.8"
  }

  remote {
    address = "169.254.255.1"
    as      = 64579
  }

  output {
    redistribute = "connected,bgp"
    network      = "local"
  }
}

resource "routeros_routing_bgp_connection" "internal" {
  for_each = {
    bag-bcm   = "169.254.255.4"
    sneakynet = "169.254.255.6"
    minitel   = "169.254.255.7"
    net-b     = "169.254.255.5"
  }

  as   = 64582
  name = each.key

  connect        = true
  listen         = true
  nexthop_choice = "force-self"

  cluster_id = "169.254.255.1"
  router_id  = "169.254.255.8"

  hold_time      = "30s"
  keepalive_time = "10s"

  local {
    role    = "ibgp"
    address = "169.254.255.8"
  }

  remote {
    address = each.value
  }

  output {
    default_originate = "if-installed"
    redistribute      = "connected,bgp"
    network           = "local"
  }
}

resource "routeros_routing_bgp_connection" "adjacent" {
  for_each = {}

  as   = 64582
  name = each.key

  connect        = true
  listen         = true
  nexthop_choice = "force-self"

  cluster_id = "169.254.255.1"
  router_id  = "169.254.255.8"

  hold_time      = "30s"
  keepalive_time = "10s"

  local {
    role    = "ebgp"
    address = "169.254.255.8"
  }

  remote {
    address = each.value.addr
    as = each.value.asn
  }

  output {
    default_originate = "if-installed"
    redistribute      = "connected,bgp"
    network           = "local"
  }
}
