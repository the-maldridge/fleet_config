variable "name" {
  type        = string
  description = "Name of the container"
}

variable "bridge" {
  type        = string
  description = "Name of the bridge to create VETH interfaces on"
}

variable "container_mac" {
  type        = string
  description = "MAC address to assign to the VETH interface."
}

variable "vlan" {
  type        = number
  description = "VLAN to attach the container to"
  default     = 10
}

variable "image" {
  type        = string
  description = "Container Image to run (registry path)"
  default     = null
}

variable "file" {
  type        = string
  description = "Container Image to run (file path)"
  default     = null
}

variable "cmd" {
  type        = string
  description = "Command to launch"
}

variable "root_dir" {
  type        = string
  description = "Root directory for the container"
}

variable "env" {
  type        = map(string)
  description = "Map of environment key/value pairs"
  default     = {}
}

variable "mounts" {
  type = map(object({
    src = string
    dst = string
  }))
  description = "Map of mount target to mount source"
  default     = {}
}
