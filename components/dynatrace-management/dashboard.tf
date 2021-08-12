resource "dynatrace_dashboard" "On-call_Dashboard_Demo" {
  dashboard_metadata {
    name   = "Platform Ops Oncall Dashboard"
    owner  = "chris.orisawayi@hmcts.net"
    shared = true
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### CCD Case Management\n\n\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 0
      top    = 722
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-77E3F438670CBB8C"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 0
      top    = 760
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "###IDAM \n\n\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 304
      top    = 722
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-259E11691F39FF07"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 304
      top    = 760
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Appeal Benefit Decision (SSCS)\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 608
      top    = 722
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-8145F12E5FA9E7F8"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 608
      top    = 760
      width  = 304
    }
  }
  tile {
    name       = "Custom chart"
    configured = true
    tile_type  = "CUSTOM_CHARTING"
    bounds {
      height = 304
      left   = 0
      top    = 380
      width  = 304
    }
    filter {
      timeframe = "-1h"
    }
    filter_config {
      type         = "MIXED"
      custom_name  = "Availability rate [HTTP monitor]"
      default_name = "Custom chart"
      chart_config {
        type   = "TOP_LIST"
        legend = true
        series {
          type             = "LINE"
          aggregation      = "AVG"
          aggregation_rate = "TOTAL"
          entity_type      = "SYNTHETIC_HTTPCHECK"
          metric           = "builtin:synthetic.http.availability.location.total"
          sort_ascending   = false
          sort_column      = true
          dimension {
            name             = "dt.entity.http_check"
            entity_dimension = true
            id               = "0"
          }
        }
      }
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "## CFT Availability\n\t\nAvailability for monitored CFT services\n\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 76
      left   = 0
      top    = 0
      width  = 1520
    }
    filter {
      timeframe = "Last 2 hours"
    }
  }
  tile {
    name          = "Synthetic monitor health"
    chart_visible = true
    configured    = true
    tile_type     = "SYNTHETIC_TESTS"
    bounds {
      height = 304
      left   = 0
      top    = 76
      width  = 1520
    }
    filter {
      timeframe = "-30m"
    }
  }
  tile {
    name       = ""
    configured = true
    tile_type  = "CUSTOM_CHARTING"
    bounds {
      height = 304
      left   = 304
      top    = 380
      width  = 418
    }
    filter {
      timeframe = "-1h"
      management_zone {
        name = "CFT"
        id   = "-1016681994524158509"
      }
    }
    filter_config {
      type         = "MIXED"
      custom_name  = "Number of HTTP 5xx errors"
      default_name = "Custom chart"
      chart_config {
        type   = "TIMESERIES"
        legend = true
        series {
          type             = "BAR"
          aggregation      = "NONE"
          aggregation_rate = "SECOND"
          entity_type      = "SERVICE"
          metric           = "builtin:service.errors.fivexx.count"
          sort_ascending   = false
          sort_column      = true
          dimension {
            name             = "dt.entity.service"
            entity_dimension = true
            id               = "0"
          }
        }
      }
    }
  }
  tile {
    name       = ""
    configured = true
    tile_type  = "CUSTOM_CHARTING"
    bounds {
      height = 304
      left   = 722
      top    = 380
      width  = 380
    }
    filter {
      timeframe = "-1h"
      management_zone {
        name = "CFT"
        id   = "-1016681994524158509"
      }
    }
    filter_config {
      type         = "MIXED"
      custom_name  = "Number of HTTP 4xx errors"
      default_name = "Custom chart"
      chart_config {
        type   = "TIMESERIES"
        legend = true
        series {
          type             = "BAR"
          aggregation      = "NONE"
          aggregation_rate = "SECOND"
          entity_type      = "SERVICE"
          metric           = "builtin:service.errors.fourxx.count"
          sort_ascending   = false
          sort_column      = true
          dimension {
            name             = "dt.entity.service"
            entity_dimension = true
            id               = "0"
          }
        }
      }
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-F0B7C9875F71D641"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 912
      top    = 760
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Apply for Probate\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 912
      top    = 722
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-75D2124FEFFE7F02"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 1216
      top    = 760
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Bulk Print - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 1216
      top    = 722
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Bulk Scan (orchestrator) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 0
      top    = 1102
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-271DB52DAFA31C3A"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 0
      top    = 1140
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Bulk Scan (payment-processor) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 304
      top    = 1102
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-D8891F77F743DC94"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 304
      top    = 1140
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-EE04B3A62997806B"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 608
      top    = 1140
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Bulk Scan (processor) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 608
      top    = 1102
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-14107C2B70F7405A"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 912
      top    = 1140
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Bulk Scan (reform-scan-notification-service) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 912
      top    = 1102
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-830532CC9D2DCF38"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 1216
      top    = 1140
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### CCD Platform (Private)\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 1216
      top    = 1102
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-DCB5E0A46A90EDCF"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 0
      top    = 1520
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### ccd-api-gateway-web Prod Health\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 0
      top    = 1482
      width  = 304
    }
  }
  tile {
    name        = "HTTP 5xx Errors - Count"
    configured  = true
    custom_name = "Data explorer results"
    tile_type   = "DATA_EXPLORER"
    unknowns    = "{\"queries\":[{\"enabled\":true,\"id\":\"A\",\"metric\":\"builtin:service.errors.fivexx.rate\",\"spaceAggregation\":\"COUNT\",\"timeAggregation\":\"DEFAULT\"}],\"visualConfig\":{\"axes\":{\"xAxis\":{\"visible\":true},\"yAxes\":[]},\"global\":{\"seriesType\":\"LINE\",\"theme\":\"DEFAULT\",\"threshold\":{\"axisTarget\":\"LEFT\",\"columnId\":\"Number of HTTP 5xx errors\",\"rules\":[{\"color\":\"#7dc540\"},{\"color\":\"#f5d30f\"},{\"color\":\"#dc172a\"}]}},\"rules\":[{\"matcher\":\"A:\",\"properties\":{\"color\":\"DEFAULT\",\"seriesType\":\"COLUMN\"}}],\"type\":\"GRAPH_CHART\"}}"
    bounds {
      height = 304
      left   = 1102
      top    = 380
      width  = 418
    }
    filter {
      timeframe = "-6h"
      management_zone {
        name = "CFT"
        id   = "-1016681994524158509"
      }
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-813F1EF87038E3A8"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 912
      top    = 1520
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-C316F569F3202D13"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 1216
      top    = 1520
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-7BCA00F009794800"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 0
      top    = 1900
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-9C7C4001CAA63CCB"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 304
      top    = 1520
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-6C9CD3F575DE727C"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 608
      top    = 1520
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### CVP - Availability\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 304
      top    = 1482
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### CVP - Availability (Admin Login URL)\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 608
      top    = 1482
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### CVP_Test_Call_Availability\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 912
      top    = 1482
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Divorce (Apply) - Availability\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 1216
      top    = 1482
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Divorce (DA) - Availability\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 0
      top    = 1862
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-9FA0B1BE744E11F1"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 304
      top    = 1900
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Divorce (DN) - Availability\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 304
      top    = 1862
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-8CEC7147F89D5334"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 608
      top    = 1900
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Divorce (RFE) - Availability\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 608
      top    = 1862
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-3B40C9FC89F82AE0"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 912
      top    = 1900
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-79E9A39242A3CD26"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 304
      top    = 2280
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-F74D2890A8C306F4"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 608
      top    = 2280
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-566A07BA5A947163"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 1216
      top    = 1900
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-BF8F9B3B36811585"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 0
      top    = 2280
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-136E443E1F560BEE"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 912
      top    = 2280
      width  = 304
    }
  }
  tile {
    name              = "HTTP monitor"
    assigned_entities = ["HTTP_CHECK-06C0517B2B83FF96"]
    configured        = true
    tile_type         = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left   = 1216
      top    = 2280
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Evidence Management (em-anno) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 0
      top    = 2242
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Evidence Management (em-hrs-api) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 304
      top    = 2242
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Employment Tribunal - Availability\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 912
      top    = 1862
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Evidence Management (dm-store) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 1216
      top    = 1862
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Evidence Management (em-icp) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 608
      top    = 2242
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Evidence Management (em-npa) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 912
      top    = 2242
      width  = 304
    }
  }
  tile {
    name       = "Markdown"
    configured = true
    markdown   = "### Evidence Management (em-orchestrator) - Private\n"
    tile_type  = "MARKDOWN"
    bounds {
      height = 38
      left   = 1216
      top    = 2242
      width  = 304
    }
  }
}
