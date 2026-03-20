output "bridge_name" {
  description = "Name of the bridge"
  value       = routeros_interface_bridge.br0.name
}
