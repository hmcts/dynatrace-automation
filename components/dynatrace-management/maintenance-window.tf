resource "dynatrace_maintenance_window" "maintenance_window" {
  for_each = { for window in var.maintenance_windows : window.name => window }

  name                    = each.value.name
  description             = each.value.description
  type                    = each.value.type
  suppress_synth_mon_exec = each.value.suppress-synth_mon_exec
  suppression             = each.value.suppression
  schedule {
    end             = each.value.schedule.end
    recurrence_type = each.value.schedule.recurrence_type
    start           = each.value.schedule.start
    zone_id         = each.value.schedule.zone_id
  }
  dynamic "scope" {
    for_each = each.value.scope != {} ? [each.value.scope] : []

    content {
      entities = lookup(each.value.scope, "entities", [])

      dynamic "matches" {
        iterator = matches
        for_each = lookup(each.value.scope, "matches", [])

        content {
          type            = matches.value.type
          tag_combination = matches.value.tag_combination

          dynamic "tags" {
            iterator = tags
            for_each = lookup(matches.value, "tags", [])

            content {
              context = tags.value.context
              key     = tags.value.key
              value   = tags.value.value
            }
          }
        }
      }
    }
  }
}