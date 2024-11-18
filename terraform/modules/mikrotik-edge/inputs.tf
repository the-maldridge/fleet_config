variable "hostname" {
  type        = string
  default     = "Mikrotik"
  description = "Device Hostname"
}

variable "subnets" {
  type        = map(any)
  description = "Map of network to subnet"
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

variable "ports" {
  type        = map(set(string))
  description = "Map of ports to assign to each network"
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
