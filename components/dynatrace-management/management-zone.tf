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
          dynamic "cloud_type" {
            iterator = cloud_type
            for_each = { for k, v in conditions.value : k => v if k == "cloud_type" }
            content {
              operator = cloud_type.value.operator
              negate   = cloud_type.value.negate
              value    = cloud_type.value.value
            }
          }
          dynamic "cloud_type_comparison" {
            iterator = cloud_type_comparison
            for_each = { for k, v in conditions.value : k => v if k == "cloud_type_comparison" }
            content {
              operator = cloud_type_comparison.value.operator
              negate   = cloud_type_comparison.value.negate
              type     = cloud_type_comparison.value.type
              value    = cloud_type_comparison.value.value
            }
          }
          dynamic "comparison" {
            iterator = comparison
            for_each = { for k, v in conditions.value : k => v if k == "comparison" }
            content {
              type   = comparison.value.type
              negate = comparison.value.negate
            }
          }
          dynamic "custom_application_type" {
            iterator = custom_application_type
            for_each = { for k, v in conditions.value : k => v if k == "custom_application_type" }
            content {
              operator = custom_application_type.value.operator
              negate   = custom_application_type.value.negate
              value    = custom_application_type.value.value
            }
          }
          dynamic "custom_application_type_comparison" {
            iterator = custom_application_type_comparison
            for_each = { for k, v in conditions.value : k => v if k == "custom_application_type_comparison" }
            content {
              operator = custom_application_type_comparison.value.operator
              negate   = custom_application_type_comparison.value.negate
              type     = custom_application_type_comparison.value.type
              value    = custom_application_type_comparison.value.value
            }
          }
          dynamic "custom_host_metadata" {
            iterator = custom_host_metadata
            for_each = { for k, v in conditions.value : k => v if k == "custom_host_metadata" }
            content {
              attribute = custom_host_metadata.value.attribute
              dynamic_key {
                key    = custom_host_metadata.value.value.key
                source = custom_host_metadata.value.value.source
              }
            }
          }
          dynamic "custom_host_metadata_condition_key" {
            iterator = custom_host_metadata_condition_key
            for_each = { for k, v in conditions.value : k => v if k == "custom_host_metadata_condition_key" }
            content {
              attribute = custom_host_metadata_condition_key.value.attribute
              type      = custom_host_metadata_condition_key.value.type
              dynamic_key {
                key    = custom_host_metadata_condition_key.value.value.key
                source = custom_host_metadata_condition_key.value.value.source
              }
            }
          }
          dynamic "custom_process_metadata" {
            iterator = custom_process_metadata
            for_each = { for k, v in conditions.value : k => v if k == "custom_process_metadata" }
            content {
              attribute = custom_process_metadata.value.attribute
              dynamic_key {
                key    = custom_process_metadata.value.value.key
                source = custom_process_metadata.value.value.source
              }
            }
          }
          dynamic "custom_process_metadata_condition_key" {
            iterator = custom_process_metadata_condition_key
            for_each = { for k, v in conditions.value : k => v if k == "custom_process_metadata_condition_key" }
            content {
              attribute = custom_process_metadata_condition_key.value.attribute
              type      = custom_process_metadata_condition_key.value.type
              dynamic_key {
                key    = custom_process_metadata_condition_key.value.value.key
                source = custom_process_metadata_condition_key.value.value.source
              }
            }
          }
          dynamic "database_topology" {
            iterator = database_topology
            for_each = { for k, v in conditions.value : k => v if k == "database_topology" }
            content {
              operator = database_topology.value.operator
              negate   = database_topology.value.negate
              value    = database_topology.value.value
            }
          }
          dynamic "database_topology_comparison" {
            iterator = database_topology_comparison
            for_each = { for k, v in conditions.value : k => v if k == "database_topology_comparison" }
            content {
              operator = database_topology_comparison.value.operator
              negate   = database_topology_comparison.value.negate
              type     = database_topology_comparison.value.type
              value    = database_topology_comparison.value.value
            }
          }
          dynamic "dcrum_decoder" {
            iterator = dcrum_decoder
            for_each = { for k, v in conditions.value : k => v if k == "dcrum_decoder" }
            content {
              operator = dcrum_decoder.value.operator
              negate   = dcrum_decoder.value.negate
              value    = dcrum_decoder.value.value
            }
          }
          dynamic "dcrum_decoder_comparison" {
            iterator = dcrum_decoder_comparison
            for_each = { for k, v in conditions.value : k => v if k == "dcrum_decoder_comparison" }
            content {
              operator = dcrum_decoder_comparison.value.operator
              negate   = dcrum_decoder_comparison.value.negate
              type     = dcrum_decoder_comparison.value.type
              value    = dcrum_decoder_comparison.value.value
            }
          }
          dynamic "entity" {
            iterator = entity
            for_each = { for k, v in conditions.value : k => v if k == "entity" }
            content {
              operator = entity.value.operator
              negate   = entity.value.negate
              value    = entity.value.value
            }
          }
          dynamic "entity_id_comparison" {
            iterator = entity_id_comparison
            for_each = { for k, v in conditions.value : k => v if k == "entity_id_comparison" }
            content {
              operator = entity_id_comparison.value.operator
              negate   = entity_id_comparison.value.negate
              type     = entity_id_comparison.value.type
              value    = entity_id_comparison.value.value
            }
          }
          dynamic "host_tech" {
            iterator = host_tech
            for_each = { for k, v in conditions.value : k => v if k == "host_tech" }
            content {
              negate   = host_tech.value.negate
              operator = host_tech.value.operator
              value {
                type          = host_tech.value.value.type
                verbatim_type = host_tech.value.value.verbatim_type
              }
            }
          }
          dynamic "hypervisor" {
            iterator = hypervisor
            for_each = { for k, v in conditions.value : k => v if k == "hypervisor" }
            content {
              operator = hypervisor.value.operator
              negate   = hypervisor.value.negate
              value    = hypervisor.value.value
            }
          }
          dynamic "hypervisor_type_comparision" {
            iterator = hypervisor_type_comparision
            for_each = { for k, v in conditions.value : k => v if k == "hypervisor_type_comparision" }
            content {
              operator = hypervisor_type_comparision.value.operator
              negate   = hypervisor_type_comparision.value.negate
              type     = hypervisor_type_comparision.value.type
              value    = hypervisor_type_comparision.value.value
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
          dynamic "indexed_name_comparison" {
            iterator = indexed_name_comparison
            for_each = { for k, v in conditions.value : k => v if k == "indexed_name_comparison" }
            content {
              operator = indexed_name_comparison.value.operator
              negate   = indexed_name_comparison.value.negate
              type     = indexed_name_comparison.value.type
              value    = indexed_name_comparison.value.value
            }
          }
          dynamic "indexed_string" {
            iterator = indexed_string
            for_each = { for k, v in conditions.value : k => v if k == "indexed_string" }
            content {
              operator = indexed_string.value.operator
              negate   = indexed_string.value.negate
              value    = indexed_string.value.value
            }
          }
          dynamic "indexed_string_comparison" {
            iterator = indexed_string_comparison
            for_each = { for k, v in conditions.value : k => v if k == "indexed_string_comparison" }
            content {
              operator = indexed_string_comparison.value.operator
              negate   = indexed_string_comparison.value.negate
              type     = indexed_string_comparison.value.type
              value    = indexed_string_comparison.value.value
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
                value   = lookup(indexed_tag.value.value, "value", "")
              }
            }
          }
          dynamic "indexed_tag_comparison" {
            iterator = indexed_tag_comparison
            for_each = { for k, v in conditions.value : k => v if k == "indexed_tag_comparison" }
            content {
              negate   = indexed_tag_comparison.value.negate
              operator = indexed_tag_comparison.value.operator
              value {
                context = indexed_tag_comparison.value.value.context
                key     = indexed_tag_comparison.value.value.key
                value   = lookup(indexed_tag_comparison.value.value, "value", "")
              }
            }
          }
          dynamic "integer" {
            iterator = integer
            for_each = { for k, v in conditions.value : k => v if k == "integer" }
            content {
              operator = integer.value.operator
              negate   = integer.value.negate
              value    = integer.value.value
            }
          }
          dynamic "integer_comparison" {
            iterator = integer_comparison
            for_each = { for k, v in conditions.value : k => v if k == "integer_comparison" }
            content {
              operator = integer_comparison.value.operator
              negate   = integer_comparison.value.negate
              type     = integer_comparison.value.type
              value    = integer_comparison.value.value
            }
          }
          dynamic "ipaddress" {
            iterator = ipaddress
            for_each = { for k, v in conditions.value : k => v if k == "ipaddress" }
            content {
              operator       = ipaddress.value.operator
              case_sensitive = ipaddress.value.case_sensitive
              negate         = ipaddress.value.negate
              value          = ipaddress.value.value
            }
          }
          dynamic "ipaddress_comparison" {
            iterator = ipaddress_comparison
            for_each = { for k, v in conditions.value : k => v if k == "ipaddress_comparison" }
            content {
              operator       = ipaddress_comparison.value.operator
              case_sensitive = ipaddress_comparison.value.case_sensitive
              negate         = ipaddress_comparison.value.negate
              type           = ipaddress_comparison.value.type
              value          = ipaddress_comparison.value.value
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
          dynamic "mobile_platform" {
            iterator = mobile_platform
            for_each = { for k, v in conditions.value : k => v if k == "mobile_platform" }
            content {
              operator = mobile_platform.value.operator
              negate   = mobile_platform.value.negate
              value    = mobile_platform.value.value
            }
          }
          dynamic "mobile_platform_comparison" {
            iterator = mobile_platform_comparison
            for_each = { for k, v in conditions.value : k => v if k == "mobile_platform_comparison" }
            content {
              operator = mobile_platform_comparison.value.operator
              negate   = mobile_platform_comparison.value.negate
              type     = mobile_platform_comparison.value.type
              value    = mobile_platform_comparison.value.value
            }
          }
          dynamic "os_arch" {
            iterator = os_arch
            for_each = { for k, v in conditions.value : k => v if k == "os_arch" }
            content {
              operator = os_arch.value.operator
              negate   = os_arch.value.negate
              value    = os_arch.value.value
            }
          }
          dynamic "os_type" {
            iterator = os_type
            for_each = { for k, v in conditions.value : k => v if k == "os_type" }
            content {
              operator = os_type.value.operator
              negate   = os_type.value.negate
              value    = os_type.value.value
            }
          }
          dynamic "osarchitecture_comparison" {
            iterator = osarchitecture_comparison
            for_each = { for k, v in conditions.value : k => v if k == "osarchitecture_comparison" }
            content {
              operator = osarchitecture_comparison.value.operator
              negate   = osarchitecture_comparison.value.negate
              type     = osarchitecture_comparison.value.type
              value    = osarchitecture_comparison.value.value
            }
          }
          dynamic "ostype_comparison" {
            iterator = ostype_comparison
            for_each = { for k, v in conditions.value : k => v if k == "ostype_comparison" }
            content {
              operator = ostype_comparison.value.operator
              negate   = ostype_comparison.value.negate
              type     = ostype_comparison.value.type
              value    = ostype_comparison.value.value
            }
          }
          dynamic "paas_type" {
            iterator = paas_type
            for_each = { for k, v in conditions.value : k => v if k == "paas_type" }
            content {
              operator = paas_type.value.operator
              negate   = paas_type.value.negate
              value    = paas_type.value.value
            }
          }
          dynamic "paas_type_comparison" {
            iterator = paas_type_comparison
            for_each = { for k, v in conditions.value : k => v if k == "paas_type_comparison" }
            content {
              operator = paas_type_comparison.value.operator
              negate   = paas_type_comparison.value.negate
              type     = paas_type_comparison.value.type
              value    = paas_type_comparison.value.value
            }
          }
          dynamic "process_metadata" {
            iterator = process_metadata
            for_each = { for k, v in conditions.value : k => v if k == "process_metadata" }
            content {
              attribute   = process_metadata.value.attribute
              dynamic_key = process_metadata.value.dynamic_key
            }
          }
          dynamic "process_metadata_condition_key" {
            iterator = process_metadata_condition_key
            for_each = { for k, v in conditions.value : k => v if k == "process_metadata_condition_key" }
            content {
              attribute   = process_metadata_condition_key.value.attribute
              dynamic_key = process_metadata_condition_key.value.dynamic_key
              type        = process_metadata_condition_key.value.type
            }
          }
          dynamic "service_topology" {
            iterator = service_topology
            for_each = { for k, v in conditions.value : k => v if k == "service_topology" }
            content {
              negate   = service_topology.value.negate
              operator = service_topology.value.operator
              value    = service_topology.value.value
            }
          }
          dynamic "service_topology_comparison" {
            iterator = service_topology_comparison
            for_each = { for k, v in conditions.value : k => v if k == "service_topology_comparison" }
            content {
              operator = service_topology_comparison.value.operator
              negate   = service_topology_comparison.value.negate
              type     = service_topology_comparison.value.type
              value    = service_topology_comparison.value.value
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
          dynamic "service_type_comparison" {
            iterator = service_type_comparison
            for_each = { for k, v in conditions.value : k => v if k == "service_type_comparison" }
            content {
              operator = service_type_comparison.value.operator
              negate   = service_type_comparison.value.negate
              type     = service_type_comparison.value.type
              value    = service_type_comparison.value.value
            }
          }
          dynamic "simple_host_tech_comparison" {
            iterator = simple_host_tech_comparison
            for_each = { for k, v in conditions.value : k => v if k == "simple_host_tech_comparison" }
            content {
              operator = simple_host_tech_comparison.value.operator
              negate   = simple_host_tech_comparison.value.negate
              type     = simple_host_tech_comparison.value.type
              value {
                type          = simple_host_tech_comparison.value.value.type
                verbatim_type = simple_host_tech_comparison.value.value.verbatim_type
              }
            }
          }
          dynamic "simple_tech_comparison" {
            iterator = simple_tech_comparison
            for_each = { for k, v in conditions.value : k => v if k == "simple_tech_comparison" }
            content {
              operator = simple_tech_comparison.value.operator
              negate   = simple_tech_comparison.value.negate
              type     = simple_tech_comparison.value.type
              value {
                type          = simple_tech_comparison.value.value.type
                verbatim_type = simple_tech_comparison.value.value.verbatim_type
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
          dynamic "string_comparison" {
            iterator = string_comparison
            for_each = { for k, v in conditions.value : k => v if k == "string_comparison" }
            content {
              case_sensitive = string_comparison.value.case_sensitive
              negate         = string_comparison.value.negate
              operator       = string_comparison.value.operator
              type           = string_comparison.value.type
              value          = string_comparison.value.value
            }
          }
          dynamic "string_condition_key" {
            iterator = string_condition_key
            for_each = { for k, v in conditions.value : k => v if k == "string_condition_key" }
            content {
              attribute   = string_condition_key.value.attribute
              dynamic_key = string_condition_key.value.dynamic_key
              type        = string_condition_key.value.type
            }
          }
          dynamic "string_key" {
            iterator = string_key
            for_each = { for k, v in conditions.value : k => v if k == "string_key" }
            content {
              attribute   = string_key.value.attribute
              dynamic_key = string_key.value.dynamic_key
            }
          }
          dynamic "synthetic_engine" {
            iterator = synthetic_engine
            for_each = { for k, v in conditions.value : k => v if k == "synthetic_engine" }
            content {
              negate         = synthetic_engine.value.negate
              operator       = synthetic_engine.value.operator
              value          = synthetic_engine.value.value
            }
          }
          dynamic "synthetic_engine_type_comparison" {
            iterator = synthetic_engine_type_comparison
            for_each = { for k, v in conditions.value : k => v if k == "synthetic_engine_type_comparison" }
            content {
              negate         = synthetic_engine_type_comparison.value.negate
              operator       = synthetic_engine_type_comparison.value.operator
              type       = synthetic_engine_type_comparison.value.type
              value          = synthetic_engine_type_comparison.value.value
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
          dynamic "tag_comparison" {
            iterator = tag_comparison
            for_each = { for k, v in conditions.value : k => v if k == "tag_comparison" }
            content {
              negate   = tag_comparison.value.negate
              operator = tag_comparison.value.operator
              type = tag_comparison.value.type
              value {
                context = tag_comparison.value.value.context
                key     = tag_comparison.value.value.key
                value   = lookup(tag_comparison.value.value, "value", "")
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
        }
      }
    }
  }
}



