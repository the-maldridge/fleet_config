variable "hostname" {
  type        = string
  description = "Access Point Hostname"
}

variable "capsman_address" {
  type        = string
  description = "Address of the CAPsMAN"
}

variable "switch_ports" {
  type = map(object({
    tagged   = optional(list(number), [])
    untagged = optional(number)
  }))
  default     = {}
  description = <<-EOT
    Extra ethernet ports on the CAP that should act as switch ports on br0,
    keyed by interface name.

    tagged   - VLANs carried tagged on the port.
    untagged - VLAN admitted/egress untagged on the port (access VLAN).
               It does not need to be repeated in tagged.

    Example:
      switch_ports = {
        ether2 = { tagged = [10, 25], untagged = 30 }
        ether3 = { untagged = 25 }
      }
  EOT

  validation {
    condition     = alltrue([for name in keys(var.switch_ports) : contains(["ether1", "sfp1"], name) == false])
    error_message = "switch_ports may not reference the uplink ports (ether1, sfp1)."
  }

  validation {
    condition = alltrue([
      for name, p in var.switch_ports : length(p.tagged) > 0 || p.untagged != null
    ])
    error_message = "switch_ports entries must carry at least one VLAN via tagged or untagged."
  }

  validation {
    condition = alltrue([
      for name, p in var.switch_ports : p.untagged == null || contains(p.tagged, p.untagged) == false
    ])
    error_message = "untagged must not also appear in tagged for the same switch_ports entry."
  }

  validation {
    condition = alltrue([
      for name, p in var.switch_ports : alltrue([
        for vid in concat(p.tagged, p.untagged == null ? [] : [p.untagged]) : vid >= 2 && vid <= 4094
      ])
    ])
    error_message = "switch_ports VLAN ids must be between 2 and 4094."
  }
}
