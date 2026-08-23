resource "routeros_queue_type" "down" {
  for_each = toset([for net, attr in var.subnets : net if can(attr.limit.down)])

  name           = format("pcq-%s-download", each.key)
  kind           = "pcq"
  pcq_classifier = ["dst-address"]
}

resource "routeros_queue_type" "up" {
  for_each = toset([for net, attr in var.subnets : net if can(attr.limit.up)])

  name           = format("pcq-%s-upload", each.key)
  kind           = "pcq"
  pcq_classifier = ["src-address"]
}

resource "routeros_queue_simple" "limit" {
  for_each = { for net, attr in var.subnets : net => attr if attr.limit != null }

  name      = format("%s-limit", each.key)
  target    = [each.value.cidr]
  max_limit = format("%s/%s", each.value.limit.up, each.value.limit.down)
  queue     = format("pcq-%s-upload/pcq-%s-download", each.key, each.key)
}

resource "routeros_ip_firewall_addr_list" "slowpath" {
  for_each = { for net, attr in var.subnets : net => attr if attr.limit != null }

  address = each.value.cidr
  list    = "slowpath"
  comment = "Non-FastPath Traffic"
}
