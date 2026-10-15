variable "hostname" {
  type        = string
  default     = "Mikrotik"
  description = "Device Hostname"
}

variable "vlans" {
  type        = map(number)
  description = "Map of VLAN IDs and names"
  default = {
    lan      = 10
    trust    = 15
    wan      = 20
    skynet   = 21
    att      = 22
    starlink = 23
    media    = 25
    mgmt     = 30
    peer     = 101
  }
}

variable "additional_vlans" {
  type = map(object({
    id          = number
    description = string
  }))
  default     = {}
  description = "Additional VLANs that should process traffic"
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
