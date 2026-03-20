resource "routeros_interface_veth" "interface" {
  name        = format("veth-%s", var.name)
  comment     = format("Virtual interface for %s", var.name)
  dhcp        = true
  mac_address = var.container_mac
}

resource "routeros_interface_bridge_port" "bridge_port" {
  bridge    = var.bridge
  interface = routeros_interface_veth.interface.name
  pvid      = var.vlan
}

resource "routeros_container_envs" "envs" {
  for_each = var.env

  name  = format("%s_envs", var.name)
  key   = each.key
  value = each.value
}

# resource "routeros_container_mounts" "mounts" {
#   for_each = var.mounts

#   name = format("%s_%s", var.name, each.key)
#   src = each.value.src
#   dst = each.value.dst
# }

resource "routeros_container" "container" {
  comment       = var.name
  remote_image  = var.image
  cmd           = var.cmd
  interface     = routeros_interface_veth.interface.name
  logging       = true
  root_dir      = var.root_dir
  start_on_boot = true
  envlist       = format("%s_envs", var.name)
}
