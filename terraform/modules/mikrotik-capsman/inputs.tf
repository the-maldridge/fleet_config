variable "wifi" {
  description = "WiFi SSIDs and PSKs"
  type = map(list(object({
    ssid   = string
    band   = optional(list(string), ["5ghz"])
    auth   = optional(list(string), ["wpa2-psk", "wpa3-psk"])
    psk    = string
    hide   = optional(bool, false)
    master = optional(bool, false)
  })))
}

variable "networks" {
  description = "Reference to networks that are provided on this router"
  type        = map(string)
}

variable "interfaces" {
  description = "References to VLANs"
  type        = list(string)
}

variable "bridge" {
  description = "Reference to the Bridge"
  type        = string
}
