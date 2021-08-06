resource "dynatrace_management_zone" "management-zone" {
  for_each = { for zone in var.management_zones : zone.name => zone }

  name = each.value.name
  dynamic "rules" {
    iterator = rules
    for_each = each.value.rules
    content {
      type              = rules.value.type
      enabled           = rules.value.enabled
      propagation_types = lookup(rules.value, "propagation_types", [])
      dynamic "conditions" {
        iterator = conditions
        for_each = rules.value.conditions
        content {
          dynamic "key" {
            iterator = key
            for_each = { for k, v in conditions.value : k => v if k == "key" }
            content {
              attribute = key.value.attribute
              type      = key.value.type
            }
          }
          dynamic "tag" {
            iterator = tag
            for_each = { for k, v in conditions.value : k => v if k == "tag" }
            content {
              negate   = tag.value.negate
              operator = tag.value.operator
              value {
                context = tag.value.value.context
                key     = tag.value.value.key
                value   = lookup(tag.value.value, "value", "")
              }
            }
          }
          dynamic "tech" {
            iterator = tech
            for_each = { for k, v in conditions.value : k => v if k == "tech" }
            content {
              negate   = tech.value.negate
              operator = tech.value.operator
              value {
                type          = tech.value.value.type
                verbatim_type = lookup(tech.value.value, "verbatim_type", "")
              }
            }
          }
          dynamic "indexed_tag" {
            iterator = indexed_tag
            for_each = { for k, v in conditions.value : k => v if k == "indexed_tag" }
            content {
              negate   = indexed_tag.value.negate
              operator = indexed_tag.value.operator
              value {
                context = indexed_tag.value.value.context
                key     = indexed_tag.value.value.key
                value   = indexed_tag.value.value.value
              }
            }
          }
          dynamic "string" {
            iterator = string
            for_each = { for k, v in conditions.value : k => v if k == "string" }
            content {
              case_sensitive = string.value.case_sensitive
              negate         = string.value.negate
              operator       = string.value.operator
              value          = string.value.value
            }
          }
          dynamic "service_type" {
            iterator = service_type
            for_each = { for k, v in conditions.value : k => v if k == "service_type" }
            content {
              negate   = service_type.value.negate
              operator = service_type.value.operator
              value    = service_type.value.value
            }
          }
          dynamic "indexed_name" {
            iterator = indexed_name
            for_each = { for k, v in conditions.value : k => v if k == "indexed_name" }
            content {
              negate   = indexed_name.value.negate
              operator = indexed_name.value.operator
              value    = indexed_name.value.value
            }
          }
          dynamic "process_metadata" {
            iterator = process_metatdata
            for_each = { for k, v in conditions.value : k => v if k == "process_metadata" }
            content {
              attribute   = process_metatdata.value.attribute
              dynamic_key = process_metatdata.value.dynamic_key
            }
          }
        }
      }
    }
  }
}



