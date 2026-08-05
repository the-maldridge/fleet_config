output "bridge_name" {
  description = "Name of the bridge"
  value       = routeros_interface_bridge.br0.name
}

output "vlan_names" {
  description = "Network VLAN Interface Names"
  value = { for vlan in routeros_interface_vlan.vlan : vlan.vlan_id => vlan.name }
}
