variable "hostname" {
  type        = string
  default     = "Mikrotik"
  description = "Device Hostname"
}

variable "subnets" {
  type        = map(any)
  description = "Map of network to subnet"
}

variable "additional_upstreams" {
  type = map(object({
    id          = number
    description = string
  }))
  description = "Additional Upstream Interfaces"
  default     = {}
}

variable "dhcp_lease_time" {
  type        = string
  description = "Default DHCP Lease Duration"
  default     = "1h"
}

variable "use_site_dns" {
  type        = bool
  description = "Use DNS from WAN DHCP"
  default     = false
}

variable "dns_servers" {
  type        = list(string)
  description = "DNS Servers to forward requests to"
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "peer_address" {
  type        = string
  description = "Peer interface address"
}

variable "router_id" {
  type        = string
  description = "BGP Router ID"
}

variable "domain_name" {
  type        = string
  description = "Domain name for this router"
}

variable "ntp_servers" {
  type        = set(string)
  description = "Set of NTP servers to contact for accurate time."

  # This list is the result of a one-time resolve of pool.ntp.org
  default = ["45.79.13.206", "149.28.61.105", "148.113.194.34", "45.84.199.136"]
}

variable "ports" {
  type        = map(set(string))
  description = "Map of ports to assign to each network"
}

variable "trunks" {
  type        = set(string)
  description = "List of ports that should act as VLAN trunks"
  default     = []
}

variable "bonds" {
  type        = map(set(string))
  description = "List of sets of ports that should be part of a bond"
  default     = {}
}

variable "additional_nat_subnets" {
  type        = list(string)
  description = "Additional IP ranges that should receive NAT services"
  default     = []
}

variable "static_hosts" {
  type = map(object({
    mac   = string
    addr  = string
    cname = optional(set(string), [])
  }))
  description = "Map of static hosts"
  default     = {}
}

variable "cme_addr" {
  type        = string
  description = "Address of a CME Server"
  default     = "127.0.0.1"
}
