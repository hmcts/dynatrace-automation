resource "dynatrace_management_zone" "management-zone" {
  for_each = { for zone in var.management_zones : zone.name => zone }

  name = each.value.name
  dynamic "rules" {
    iterator = rules
    for_each = each.value.rules
    content {
      type              = rules.value.type
      enabled           = rules.value.enabled
      propagation_types = rules.value.propagation_types
      dynamic "conditions" {
        iterator = conditions
        for_each = rules.value.conditions
        content {
          dynamic "key" {
            iterator = key
            for_each = { for key in conditions.value : key.type => key if lookup(conditions.value, "key", []) != [] ? true : false }
            content {
              attribute = key.value.attribute
              type      = key.value.type
            }
          }
          dynamic "tag" {
            iterator = tag
            for_each = { for tag in conditions.value : tag.operator => tag if lookup(conditions.value, "tag", []) != [] ? true : false }
            content {
              negate   = tag.value.negate
              operator = tag.value.operator
              value {
                context = tag.value.value.context
                key     = tag.value.value.key
                value   = tag.value.value.value
              }
            }
          }
        }
      }
    }
  }
}



