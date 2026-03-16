resource "routeros_routing_bgp_instance" "docked" {
  as         = 64582
  name       = "Docked"
  comment    = "Docked Connection"
  cluster_id = "169.254.255.1"
  router_id  = "169.254.255.9"
}

resource "routeros_routing_bgp_connection" "docked" {
  as       = 64582
  name     = "p0rtalNet-core"
  instance = routeros_routing_bgp_instance.docked.name

  connect        = true
  listen         = true
  nexthop_choice = "force-self"

  hold_time      = "30s"
  keepalive_time = "10s"

  local {
    role    = "ebgp"
    address = "169.254.255.9"
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

resource "routeros_routing_bgp_instance" "internal" {
  as         = 64582
  name       = "Internal"
  comment    = "Internal Peers"
  cluster_id = "169.254.255.1"
  router_id  = "169.254.255.9"
}

resource "routeros_routing_bgp_connection" "internal" {
  for_each = {
    minicluster = "169.254.255.2"
    bag-bcm     = "169.254.255.4"
    sneakynet   = "169.254.255.6"
    minitel     = "169.254.255.7"
    net-a       = "169.254.255.8"
    net-b       = "169.254.255.5"
  }

  as       = 64582
  name     = each.key
  instance = routeros_routing_bgp_instance.internal.name

  connect        = true
  listen         = true
  nexthop_choice = "force-self"

  hold_time      = "30s"
  keepalive_time = "10s"

  local {
    role    = "ibgp"
    address = "169.254.255.5"
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

resource "routeros_routing_bgp_instance" "adjacent" {
  as         = 64582
  name       = "Adjacent"
  comment    = "Adjacent Peers"
  cluster_id = "169.254.255.1"
  router_id  = "169.254.255.9"
}

resource "routeros_routing_bgp_connection" "adjacent" {
  for_each = {
    mal = {
      asn  = 64513
      addr = "169.254.255.25"
    }
  }

  as       = 64582
  name     = each.key
  instance = routeros_routing_bgp_instance.internal.name

  connect        = true
  listen         = true
  nexthop_choice = "force-self"

  hold_time      = "30s"
  keepalive_time = "10s"

  local {
    role    = "ebgp"
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
