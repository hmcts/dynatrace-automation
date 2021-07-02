resource "dynatrace_dashboard" "On-call_Dashboard_Demo" {
  dashboard_metadata {
    name = "Platform Ops On-call Dashboard Demo2"
    owner = "chris.orisawayi@hmcts.net"
    shared = true
  }
  tile {
    name = "Markdown"
    configured = true
    markdown = "## Monitored Service Title\nhttps://www.url.platform.hmcts.net/health\n\n"
    tile_type = "MARKDOWN"
    bounds {
      height = 114
      left = 0
      top = 418
      width = 304
    }
  }
  tile {
    name = "HTTP monitor"
    assigned_entities = ["CMC AAT Availability"]
    configured = true
    tile_type = "SYNTHETIC_HTTP_MONITOR"
    bounds {
      height = 304
      left = 0
      top = 532
      width = 304
    }
  }

  tile {
    name = "Synthetic monitor health"
    chart_visible = true
    configured = true
    tile_type = "SYNTHETIC_TESTS"
    bounds {
      height = 304
      left = 0
      top = 76
      width = 912
    }
    filter {
      timeframe = "-30m"
    }
  }
}
