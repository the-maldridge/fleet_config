variable "records" {
  type        = map(set(string))
  description = "Map of IP to name"
}

variable "default_zone" {
  type        = string
  description = "Default zone to put records in if un-anchored."
}
