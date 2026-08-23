resource "routeros_ip_dns_record" "record" {
  for_each = merge([for ip, records in var.records : {
    for record in records :
    endswith(record, ".") ? trimsuffix(record, ".") : format("%s.%s", record, var.default_zone) => ip
  }]...)

  name    = each.key
  type    = "A"
  address = each.value
}
