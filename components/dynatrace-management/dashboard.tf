resource "dynatrace_dashboard" "dashboard" {
  for_each = { for dashboard in var.dashboards : dashboard.name => dashboard }

  dashboard_metadata {
    name              = each.value.name
    owner             = lookup(each.value, "owner", null)
    shared            = lookup(each.value, "shared", null)
    tags              = lookup(each.value, "tags", null)
    unknowns          = lookup(each.value, "unknowns", null)
    valid_filter_keys = lookup(each.value, "valid_filter_keys", null)
    dynamic "dynamic_filters" {
      iterator = dynamic_filters
      for_each = lookup(each.value, "dynamic_filters", [])
      content {
        filters              = dynamic_filters.value.filters
        tag_suggestion_types = lookup(dynamic_filters.value, "tag_suggestion_types", [])
      }
    }
    dynamic "filter" {
      iterator = filter
      for_each = lookup(each.value, "filter", [])
      content {
        timeframe = lookup(filter.value, "timeframe", null)
        dynamic "management_zone" {
          iterator = management_zone
          for_each = lookup(filter.value, "management_zone", [])
          content {
            id          = management_zone.value.id
            description = lookup(management_zone.value, "description", null)
            name        = lookup(management_zone.value, "name", null)
          }
        }
      }
    }
    dynamic "sharing_details" {
      iterator = sharing_details
      for_each = lookup(each.value, "sharing_details", [])
      content {
        link_shared = lookup(sharing_details.value, "link_shared", false)
        published   = lookup(sharing_details.value, "published", false)
      }
    }
  }

  dynamic "tile" {
    iterator = tile
    for_each = each.value.tiles
    content {
      name                        = lookup(tile.value, "name", null)
      chart_visible               = lookup(tile.value, "chart_visible", true)
      assigned_entities           = lookup(tile.value, "assigned_entities", null)
      configured                  = lookup(tile.value, "configured", null)
      custom_name                 = lookup(tile.value, "custom_name", null)
      exclude_maintenance_windows = lookup(tile.value, "exclude_maintenance_windows", null)
      markdown                    = lookup(tile.value, "markdown", null)
      limit                       = lookup(tile.value, "limit", null)
      metric                      = lookup(tile.value, "metric", null)
      query                       = lookup(tile.value, "query", null)
      time_frame_shift            = lookup(tile.value, "time_frame_shift", null)
      type                        = lookup(tile.value, "type", "")
      tile_type                   = lookup(tile.value, "tile_type", null)
      unknowns                    = lookup(tile.value, "unknowns", null)
      visualization               = lookup(tile.value, "visualization", null)
      dynamic "bounds" {
        iterator = bounds
        for_each = lookup(tile.value, "bounds", [])
        content {
          height = bounds.value.height
          left   = bounds.value.left
          top    = bounds.value.top
          width  = bounds.value.width
        }
      }
      visualization_config {}
      dynamic "filter" {
        iterator = filter
        for_each = lookup(tile.value, "filter", [])
        content {
          timeframe = lookup(filter.value, "timeframe", null)
          dynamic "management_zone" {
            iterator = management_zone
            for_each = lookup(filter.value, "management_zone", [])
            content {
              id          = lookup(management_zone.value, "id", null)
              description = lookup(management_zone.value, "description", null)
              name        = lookup(management_zone.value, "name", null)
            }
          }
        }
      }
      dynamic "filter_config" {
        iterator = filter_config
        for_each = lookup(tile.value, "filter_config", [])
        content {
          type         = lookup(filter_config.value, "type", null)
          custom_name  = lookup(filter_config.value, "custom_name", null)
          default_name = lookup(filter_config.value, "default_name", null)
          dynamic "chart_config" {
            iterator = chart_config
            for_each = lookup(filter_config.value, "chart_config", [])
            content {
              type   = lookup(chart_config.value, "type", null)
              legend = lookup(chart_config.value, "legend", null)
              dynamic "series" {
                iterator = series
                for_each = lookup(chart_config.value, "series", [])
                content {
                  type             = lookup(series.value, "type", null)
                  aggregation      = lookup(series.value, "aggregation", null)
                  aggregation_rate = lookup(series.value, "aggregation_rate", null)
                  entity_type      = lookup(series.value, "entity_type", null)
                  metric           = lookup(series.value, "metric", null)
                  sort_ascending   = lookup(series.value, "sort_ascending", null)
                  sort_column      = lookup(series.value, "sort_column", null)
                  dynamic "dimension" {
                    iterator = dimension
                    for_each = lookup(series.value, "dimension", [])
                    content {
                      name             = lookup(dimension.value, "name", null)
                      entity_dimension = lookup(dimension.value, "entity_dimension", null)
                      id               = lookup(dimension.value, "id", null)
                    }
                  }

                }
              }
            }
          }
        }
      }
    }
  }
}
