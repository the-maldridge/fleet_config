variable "static_hosts" {
  type = map(object({
    mac    = string
    addr   = string
    cname  = optional(set(string), [])
    server = optional(string)
  }))
  description = "Static host bindings"
  default     = {}
}
