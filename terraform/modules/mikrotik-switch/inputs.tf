variable "hostname" {
  type        = string
  default     = "Mikrotik"
  description = "Device Hostname"
}

variable "vlans" {
  type        = map(number)
  description = "Map of VLAN IDs and names"
  default = {
    lan  = 10
    wan  = 20
    mgmt = 30
    peer = 101
  }
}

variable "trunks" {
  type        = set(string)
  description = "List of ports that should act as VLAN trunks"
  default     = []
}

variable "ports" {
  type        = map(set(string))
  description = "Map of ports to assign to each network"
  default     = {}
}
