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
          dynamic "application_type" {
            iterator = application_type
            for_each = { for k, v in conditions.value : k => v if k == "application_type" }
            content {
              operator = application_type.value.operator
              negate   = application_type.value.negate
              value    = application_type.value.value
            }
          }
          dynamic "application_type_comparison" {
            iterator = application_type
            for_each = { for k, v in conditions.value : k => v if k == "application_type_comparison" }
            content {
              operator = application_type_comparison.value.operator
              negate   = application_type_comparison.value.negate
              type     = application_type_comparison.value.type
              value    = application_type_comparison.value.value
            }
          }
          dynamic "azure_compute_mode" {
            iterator = azure_compute_mode
            for_each = { for k, v in conditions.value : k => v if k == "azure_compute_mode" }
            content {
              operator = azure_compute_mode.value.operator
              negate   = azure_compute_mode.value.negate
              value    = azure_compute_mode.value.value
            }
          }
          dynamic "azure_compute_mode_comparison" {
            iterator = azure_compute_mode_comparison
            for_each = { for k, v in conditions.value : k => v if k == "azure_compute_mode_comparison" }
            content {
              operator = azure_compute_mode_comparison.value.operator
              negate   = azure_compute_mode_comparison.value.negate
              value    = azure_compute_mode_comparison.value.value
            }
          }
          dynamic "azure_sku" {
            iterator = azure_sku
            for_each = { for k, v in conditions.value : k => v if k == "azure_sku" }
            content {
              operator = azure_sku.value.operator
              negate   = azure_sku.value.negate
              value    = azure_sku.value.value
            }
          }
          dynamic "azure_sku_comparision" {
            iterator = azure_sku_comparision
            for_each = { for k, v in conditions.value : k => v if k == "azure_sku_comparision" }
            content {
              operator = azure_sku_comparision.value.operator
              negate   = azure_sku_comparision.value.negate
              type     = azure_sku_comparision.value.type
              value    = azure_sku_comparision.value.value
            }
          }
          dynamic "base_comparison_basic" {
            iterator = base_comparison_basic
            for_each = { for k, v in conditions.value : k => v if k == "base_comparison_basic" }
            content {
              type   = base_comparison_basic.value.type
              negate = base_comparison_basic.value.negate
            }
          }
          dynamic "base_condition_key" {
            iterator = base_condition_key
            for_each = { for k, v in conditions.value : k => v if k == "base_condition_key" }
            content {
              attribute = base_condition_key.value.attribute
              type      = base_condition_key.value.type
            }
          }
          dynamic "bitness" {
            iterator = bitness
            for_each = { for k, v in conditions.value : k => v if k == "bitness" }
            content {
              operator = bitness.value.operator
              negate   = bitness.value.negate
              value    = bitness.value.value
            }
          }
          dynamic "bitness_comparision" {
            iterator = bitness_comparision
            for_each = { for k, v in conditions.value : k => v if k == "bitness_comparision" }
            content {
              operator = bitness_comparision.value.operator
              negate   = bitness_comparision.value.negate
              type     = bitness_comparision.value.type
              value    = bitness_comparision.value.value
            }
          }
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



