variable "static_hosts" {
  type = map(object({
    mac   = string
    addr  = string
    cname = optional(set(string), [])
  }))
  description = "Static host bindings"
  default     = {}
}
