variable "hostname" {
  type        = string
  description = "System Hostname"
  default     = "downlink"
}

variable "downlink_vlan" {
  type        = number
  description = "VLAN to bridge to the WLAN interface"
  default     = 21
}

variable "network_ssid" {
  type        = string
  description = "Network SSID"
  default     = "linksys"
}

variable "network_psk" {
  type        = string
  description = "Network PSK"
  default     = "123456"
}

variable "network_security_mode" {
  type        = string
  description = "Security Mode (WPA|OPEN)"
  default     = "OPEN"

  validation {
    condition     = contains(["OPEN", "WPA"], var.network_security_mode)
    error_message = "Must be one of 'WPA', 'OPEN'"
  }
}

variable "network_band" {
  type        = string
  description = "Network Band"
  default     = "2ghz-g/n"

  validation {
    condition     = contains(["2ghz-b/g/n", "2ghz-g/n", "5ghz-n/ac", "5ghz-onlyac"], var.network_band)
    error_message = "Must be one of '2ghz-g/n', '5ghz-n/ac', '5ghz-onlyac'"
  }
}
