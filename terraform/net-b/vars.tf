variable "static_hosts" {
  type = map(object({
    mac  = string
    addr = string
  }))
  description = "Static host bindings"
  default     = {}
}
