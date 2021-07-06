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
  scope {
    entities = each.value.scope.entities
    matches {
      type            = each.value.scope.matches.type
      tag_combination = each.value.scope.matches.tag_combination
      tags {
        context = each.value.scope.matches.tags.context
        key     = each.value.scope.matches.tags.key
        value   = each.value.scope.matches.tags.value
      }
    }
  }
}