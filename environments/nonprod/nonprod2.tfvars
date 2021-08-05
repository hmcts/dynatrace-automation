env                              = "nonprod"
dynatrace_environment_id         = "yrk32651"
devops_key_vault                 = "infra-vault-nonprod"
devops_key_vault_rg              = "cnp-core-infra"
devops_key_vault_subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"

maintenance_windows = [
  {
    name                    = "Example-OOH-Maintenance"
    description             = "On-call P1 test maintenance window example"
    type                    = "UNPLANNED"
    suppress-synth_mon_exec = "true"
    suppression             = "DONT_DETECT_PROBLEMS"
    schedule = {
      end             = "2021-10-27 23:00"
      recurrence_type = "ONCE"
      start           = "2021-10-27 22:00"
      zone_id         = "Europe/London"
    }
    scope = {
      entities = [
        "SERVICE-57BC0AF40537D300",
      "HOST-78090A0CDD645C1A"]
      matches = [
        {
          type            = "SERVICE"
          tag_combination = "AND"
          tags = [
            {
              context = "CONTEXTLESS"
              key     = "SVCOFF"
              value   = "SVCOFF0001242"
            }
          ]
        }
      ]
    }
  },
  {
    name                    = "Example-CH0000x-Maintenance"
    description             = "Change Request based P1 test maintenance window example"
    type                    = "PLANNED"
    suppress-synth_mon_exec = "false"
    suppression             = "DETECT_PROBLEMS_DONT_ALERT"
    schedule = {
      end             = "2021-09-27 23:00"
      recurrence_type = "ONCE"
      start           = "2021-09-27 22:00"
      zone_id         = "Europe/London"
    }
    scope = {
      entities = ["HOST-B31C54E9A0884A07"]
      matches = [
        {
          type            = "HOST"
          tag_combination = "AND"
          tags = [
            {
              context = "CONTEXTLESS"
              key     = "IDAM"
              value   = "idam-api"
            }
          ]
        }
      ]
    }
  },
  {
    name                    = "Example-OOH-Retrospective-Maintenance - empty scope"
    description             = "Test retrospective maintenance based on a previous P1 example \n with empty scope i.e. all environment"
    type                    = "UNPLANNED"
    suppress-synth_mon_exec = "false"
    suppression             = "DONT_DETECT_PROBLEMS"
    schedule = {
      end             = "2021-05-27 23:00"
      recurrence_type = "ONCE"
      start           = "2021-05-27 22:00"
      zone_id         = "Europe/London"
    }
    scope = {}
  },
]

management_zones = [
  {
    name = "CFT - Access Management - Perf"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = "true"
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            },
            key = {
              type = "STATIC123"
              attribute = "SERVICE_TAGS123"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS1"
            }
          },
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            }
          },
          {
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          }
        ]
      }
    ]


  },
]

