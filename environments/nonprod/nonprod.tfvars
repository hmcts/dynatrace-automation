env = "nonprod"
dynatrace_environment_id = "yrk32651"
devops_key_vault = "infra-vault-nonprod"
devops_key_vault_rg = "cnp-core-infra"
devops_key_vault_subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"

maintenance_windows = [
  {
    name = "CHG000x-Test-Maintenance"
    description = "Change request based test maintenance window"
    type = "PLANNED"
    suppress-synth_mon_exec = "false"
    suppression = "DON'T_DETECT_PROBLEMS"
    schedule = {
      end = "2021-09-25 23:00"
      recurrence_type = "ONCE"
      start = "2021-09-25 22:00"
      zone_id = "Europe/London"
    },
    scope = {
      entities = []
      matches = {
        type = ""
        tag_combination = ""
        tags = {
          context = ""
          key = ""
          value = ""
        }
      }
    }
  },

  {
    name = "OOH-Test-Maintenance"
    description = "On-call P1 test maintenance window"
    type = "UNPLANNED"
    suppress-synth_mon_exec = "true"
    suppression = "DON'T_DETECT_PROBLEMS"
    schedule = {
      end = "2021-10-27 23:00"
      recurrence_type = "ONCE"
      start = "2021-10-27 22:00"
      zone_id = "Europe/London"
    },
    scope = {
      entities = []
      matches = {
        type = ""
        tag_combination = ""
        tags = {
          context = ""
          key = ""
          value = ""
        }
      }
    }
  },
]

dashboards = {
  oncall = {
    tiles = [
      {
        name       = "Markdown"
        configured = true
        markdown   = "## Monitored Service Title\nhttps://www.url.platform.hmcts.net/health\n\n"
        tile_type  = "MARKDOWN"
        bounds = {
          height = 114
          left   = 0
          top    = 418
          width  = 304
        }
      }

    ]
  }
}