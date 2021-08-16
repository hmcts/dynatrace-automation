env                              = "stg"
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
      end             = "2021-05-27 23:00"
      recurrence_type = "ONCE"
      start           = "2021-05-27 22:00"
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
      end             = "2021-06-27 23:00"
      recurrence_type = "ONCE"
      start           = "2021-06-27 22:00"
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
      end             = "2021-04-27 23:00"
      recurrence_type = "ONCE"
      start           = "2021-04-27 22:00"
      zone_id         = "Europe/London"
    }
    scope = {}
  },
]

management_zones = [
  {
    name = "CFT"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "CFT"
            }
          },
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate   = false
              operator = "CONTAINS"
              value    = "DCD"
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_SUBSCRIPTION_NAME"
            }
          },
        ]
      },
      {
        type    = "KUBERNETES_CLUSTER"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "cft"
            }
          },
        ]
      },
      {
        type    = "CLOUD_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "cft"
            }
          },
        ]
      },
      {
        type    = "CLOUD_APPLICATION_NAMESPACE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "cft"
            }
          },
        ]
      },
      {
        type    = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Palo Alto - AAT"
              }
            }
          },
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "CFT AAT"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          },
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "CFT Perf"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          },
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "CFT LDATA"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          },
        ]
      }
    ]
  },
  {
    name = "CFT - Access Management - Perf"
    rules = [
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "am"
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "am "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Access Management - Staging"
    rules = [
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "am"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "am "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Bulk Scan - Perf"
    rules = [
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "bsp"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
        "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "scan"
            }
          },
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
        "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "reform-scan"
              }
            }
          }
        ]


      }
    ]
  },
  {
    name = "CFT - Bulkprint - Perf"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            process_metadata = {
              attribute   = "PROCESS_GROUP_PREDEFINED_METADATA"
              dynamic_key = "KUBERNETES_FULL_POD_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "rpe-send-letter"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            }
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "send_letter"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Bulkprint - Staging"
    rules = [
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            process_metadata = {
              attribute   = "PROCESS_GROUP_PREDEFINED_METADATA"
              dynamic_key = "KUBERNETES_FULL_POD_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "rpe-send-letter"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            }
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "send_letter"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - CCD - Perf"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = false
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ccd"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "CCD"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "perf"
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ccd "
              }
            }
          }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ccd"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "health"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - CCD - Staging"
    rules = [
      {
        type    = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ccd "
              }
            }
          },
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "ccd"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "aat"
            }
          }
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = false
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ccd "
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT "
              }
            }
          }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ccd"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = true
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = true
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "LDATA"
              }
            }
          }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001306"
              }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001306"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001306"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Civil Money Claims - Staging"
    rules = [
      {
        type    = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "cmc "
              }
            }
          }
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "money-claims"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Civil Money Claims"
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "money-claims"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001246"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001246"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001246"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Civil Unspec - Staging"
    rules = [
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "unspec"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Camun"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Manag"
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "cmc "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Divorce - Perf Test"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "divorce"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "div "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Divorce Perf Test"
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001242"
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001242"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Divorce - Staging"
    rules = [
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "div "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "cft divorce staging"
            }
          }
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "divorce"
              }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001242"
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001242"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Divorce AAT"
    rules = [
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Divorce AAT"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Divorce Demo"
    rules = [
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Divorce Demo"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - ECM - LDATA"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ethos"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "LDATA"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "ecm"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "CFT CCD"
            }
          },
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "CFT XUI"
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ethos"
              }
            }
          }
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
              attribute = "SERVICE_TECHNOLOGY"
            },
            tech = {
              negate   = false
              operator = "EQUALS"
              value = {
                type = "ELASTIC_SEARCH"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ethosldata"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - ECM - Perf"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ethos"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "ecm"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "CFT CCD Perf"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "CFT XUI"
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ethos"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - ECM - Staging"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_SERVICE",
          "PROCESS_GROUP_TO_HOST"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ethos"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "ecm"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "CFT CCD"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "CFT XUI"
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ethos"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Elasticsearch - Perf"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "ccd-data"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Elasticsearch - Staging"
    rules = [
      {
        type    = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "ccd-data"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Evidence Management - Perf"
    rules = [
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "em"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "em "
              }
            }
          }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "dg"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "dm "
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "dm-store"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Evidence Management - Staging"
    rules = [
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
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "dm "
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "em "
              }
            }
          }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "em"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "dg"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "dm-store"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Family Public Law - Perf"
    rules = [
      {
        type    = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "fpl "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Family Public Law - Perf"
            }
          }
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = false
        propagation_types = [
          "PROCESS_GROUP_TO_SERVICE",
          "PROCESS_GROUP_TO_HOST"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "family-public-law"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001260"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001260"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Family Public Law - Staging"
    rules = [
      {
        type    = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "fpl "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "family public law"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = false
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "family-public-law"
              }
            }
          }
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
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001260"
              }
            }
          }
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
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001260"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Fees \u0026 Payments - Perf"
    rules = [
      {
        type              = "SERVICE"
        enabled           = false
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "payment "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Fees \u0026 Payments - Perf"
            }
          }
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "fees-pay"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = false
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "fees-pay"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "fees-pay"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "payment "
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "fees "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Fees \u0026 Payments - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = false
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "payment "
              }
            }
          }
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "fees-pay"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Fees \u0026 Payments - AAT"
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = false
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "fees-pay"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001394"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "fees "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001394"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "payment "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Financial Remedy - AAT"
    rules = [
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Financial Remedy"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "Finrem AAT"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "financial-remedy"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001258"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001258"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Financial Remedy - Demo"
    rules = [
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Finrem Demo"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Financial Remedy - ITHC"
    rules = [
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Finrem ITHC"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Financial Remedy - Perf"
    rules = [
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Financial Remedy"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Finrem Perf"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "financial-remedy"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001258"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001258"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Forgerock - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "forgerock"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - IDAM - Perf"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "idam"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "idam "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "IDAM"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Perf"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Application"
                value   = "IDAM"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_HOST_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "idam"
            }
          }
        ]
      },
      {
        type    = "HOST"
        enabled = true
        conditions = [
          {
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "PERF_CFT_IDAM"
            },
            key = {
              type      = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "IDAM"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - IDAM - Sandbox"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "idam "
              }
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "SANDBOX"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_HOST_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "idam"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - IDAM - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "idam "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "IDAM"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "AAT"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "idam"
              }
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Application"
                value   = "IDAM"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_HOST_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "idam"
            }
          },
        ]
      },
      {
        type    = "CLOUD_APPLICATION_NAMESPACE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CLOUD_APPLICATION_NAMESPACE_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "idam"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "aat"
            }
          }
        ]
      },
      {
        type    = "HOST"
        enabled = true
        conditions = [
          {
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "AAT_CFT_IDAM"
            },
            key = {
              type      = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "IDAM"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Immigration and Asylum - Perf"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ia "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Immigration and Asylum"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "Perf"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ia"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Immigration and Asylum - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ia "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "Immigration and Asylum"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "AAT"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "ia"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - LDATA"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "LDATA"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "ldata"
            }
          }
        ]
      },
      {
        type    = "KUBERNETES_CLUSTER"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-ldata"
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate   = false
              operator = "CONTAINS"
              value    = "DCD-ETHOS-MIGRATION-LDATA"
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_NAME"
            }
          }
        ]
      },
      {
        type    = "CLOUD_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-ldata"
            }
          }
        ]
      },
      {
        type    = "CLOUD_APPLICATION_NAMESPACE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-ldata"
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-ldata"
            }
          }
        ]
      },
      {
        type              = "HOST"
        enabled           = true
        propagation_types = ["HOST_TO_PROCESS_GROUP_INSTANCE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-ldata"
            }
          }
        ]
      },
      {
        type    = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Palo Alto - LDATA"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ccd "
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "idam "
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "ethos"
              }
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "CFT LDATA"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Legal Rep (CMC Unspec)"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "cmc-legal"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Palo Non-Prod (Perf \u0026 LDATA)"
    rules = [
      {
        type    = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Palo Alto Non-Prod (Perf \u0026 LDATA)"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - PCQ - Perf"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "pcq"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
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
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "pcq "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - PCQ - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "pcq"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = true
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "health"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "pcq "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Perf"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "perf"
            }
          }
        ]
      },
      {
        type    = "KUBERNETES_CLUSTER"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-perf"
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate   = false
              operator = "CONTAINS"
              value    = "DCD-CFTAPPS-TEST"
            }
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_NAME"
            }
          }
        ]
      },
      {
        type    = "CLOUD_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-perf"
            }
          }
        ]
      },
      {
        type    = "CLOUD_APPLICATION_NAMESPACE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-perf"
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-perf"
            }
          }
        ]
      },
      {
        type              = "HOST"
        enabled           = true
        propagation_types = ["HOST_TO_PROCESS_GROUP_INSTANCE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-perf"
            }
          }
        ]
      },
      {
        type    = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Palo Alto - PERF"
              }
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "CFT Perf"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Probate - Perf"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = false
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "probate"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Probate - Perf"
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = false
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "probatemandb "
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = false
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "probate"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001244"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001244"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Probate - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = false
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "probatemandb "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "CFT Probate - AAT"
            }
          }
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = false
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "probate"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = false
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "probate"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001244"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
                value   = "SVCOFF0001244"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Professional Reference Data - Perf"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "rd"
              }
            }
          }


        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "rd "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Professional Reference Data - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "rd"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "rd "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - SSCS - Perf"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "sscs "
              }
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "sscs"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "sscs"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "perf"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - SSCS - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "sscs "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "sscs"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "aat"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "sscs"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Staging"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "aat"
            }
          }
        ]
      },
      {
        type    = "KUBERNETES_CLUSTER"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-aat"
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate   = false
              operator = "CONTAINS"
              value    = "DCD-CFTAPPS-STG"
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_NAME"
            }
          }
        ]
      },
      {
        type    = "CLOUD_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-aat"
            }
          }
        ]
      },
      {
        type    = "CLOUD_APPLICATION_NAMESPACE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-aat"
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-aat"
            }
          }
        ]
      },
      {
        type              = "HOST"
        enabled           = true
        propagation_types = ["HOST_TO_PROCESS_GROUP_INSTANCE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cft-aat"
            }
          }
        ]
      },
      {
        type    = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Palo Alto - AAT"
              }
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "CFT AAT"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Work Allocation"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE", "SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Work Allocation"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - XUI - Perf"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "xui"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "xui "
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - XUI - Staging"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "CFT Database"
                value   = "xui "
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "xui"
            }
          }
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "xui"
              }
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "NS"
                value   = "xui"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "Crime"
    rules = [
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "crime"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CRIME"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Crime-PRX"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Crime-CPP"
                value   = "PRX"
              }
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate   = false
              operator = "CONTAINS"
              value    = "Strategic Platform - non-live"
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_SUBSCRIPTION_NAME"
            }
          }
        ]
      },
      {
        type              = "CUSTOM_DEVICE_GROUP"
        enabled           = true
        propagation_types = ["CUSTOM_DEVICE_GROUP_TO_CUSTOM_DEVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_GROUP_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "azure"
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "Crime CP Non-live"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          }
        ]
      }
    ]
  },
  {
    name = "Crime - CP (NFT)"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Application"
                value   = "CP"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CRIME"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "NFT"
              }
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate   = false
              operator = "CONTAINS"
              value    = "Strategic Platform - non-live"
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_SUBSCRIPTION_NAME"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "Crime CPP NFT"
            }
          }
        ]
      },
      {
        type              = "CUSTOM_DEVICE_GROUP"
        enabled           = true
        propagation_types = ["CUSTOM_DEVICE_GROUP_TO_CUSTOM_DEVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_GROUP_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "azure"
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "Crime CP Non-live"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          }
        ]
      }
    ]
  },
  {
    name = "Crime - IdAM - NFT"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_GROUP_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "NFT_CRIME_ID"
            }
          }
        ]
      }
    ]
  },
  {
    name = "Crime - ROTA (NFT)"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
            string = {
              case_sensitive = true
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "NFT_CRIME_RT"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "EQUALS"
              value          = "Crime ROTA NFT"
            }
          }
        ]
      }
    ]
  },
  {
    name = "Crime CP (MDV)"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CRIME"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "MDV"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Application"
                value   = "CP"
              }
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate   = false
              operator = "EQUALS"
              value    = "Strategic Platform - non-live"
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_SUBSCRIPTION_NAME"
            }
          }
        ]
      },
      {
        type              = "CUSTOM_DEVICE_GROUP"
        enabled           = true
        propagation_types = ["CUSTOM_DEVICE_GROUP_TO_CUSTOM_DEVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_GROUP_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "BEGINS_WITH"
              value          = "azure"
            }
          }
        ]
      },
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Azure Entities"
                value   = "Crime CP Non-live"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          }
        ]
      }
    ]
  },
  {
    name = "DTS - CVP - Perf"
    rules = [
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE", "PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "CFT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Application"
                value   = "CVP"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "PERF"
              }
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cvp"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cvp"
            }
          }
        ]
      }
    ]
  },
  {
    name = "DTS - CVP - Staging"
    rules = [
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cvp"
            }
          }
        ]
      },
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = false
              negate         = false
              operator       = "CONTAINS"
              value          = "cvp"
            }
          }
        ]
      },
      {
        type              = "PROCESS_GROUP"
        enabled           = true
        propagation_types = ["PROCESS_GROUP_TO_HOST", "PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Environment"
                value   = "AAT"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Department"
                value   = "DTS"
              }
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "Application"
                value   = "CVP"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "DTS - FACT - AAT"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "AAT_CFT"
            },
            key = {
              type      = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
          },
          {
            process_metadata = {
              attribute   = "PROCESS_GROUP_PREDEFINED_METADATA"
              dynamic_key = "KUBERNETES_NAMESPACE"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "fact"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "DTS FACT AAT"
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "fact"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_HOST_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "fact-aat.postgres.database.azure.com"
            }
          }
        ]
      }
    ]
  },
  {
    name = "DTS - FACT - Perf"
    rules = [
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "PERF_CFT"
            },
            key = {
              type      = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
          },
          {
            process_metadata = {
              attribute   = "PROCESS_GROUP_PREDEFINED_METADATA"
              dynamic_key = "KUBERNETES_NAMESPACE"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "fact"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "DTS FACT Perf"
            }
          }
        ]
      },
      {
        type              = "SERVICE"
        enabled           = true
        propagation_types = ["SERVICE_TO_HOST_LIKE", "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate   = false
              operator = "EQUALS"
              value    = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "fact"
            }
          },
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_DATABASE_HOST_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "fact-perftest.postgres.database.azure.com"
            }
          }
        ]
      }
    ]
  },
  {
    name = "DTS - HMI - Dev"
    rules = [
      {
        type              = "AZURE"
        enabled           = true
        propagation_types = ["AZURE_TO_PG", "AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate   = false
              operator = "EQUALS"
              value    = "DTS-SHAREDSERVICES-DEV"
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_SUBSCRIPTION_NAME"
            }
          }
        ]
      }
    ]
  },
  {
    name = "DTS - NFDIV - AAT"
    rules = [
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "AAT_CFT"
            },
            key = {
              type      = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
          },
          {
            process_metadata = {
              attribute   = "PROCESS_GROUP_PREDEFINED_METADATA"
              dynamic_key = "KUBERNETES_NAMESPACE"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "nfdiv"
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "CFT No Fault"
            }
          }
        ]
      }
    ]
  },
  {
    name = "DTS - NFDIV - PERF"
    rules = [
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            string = {
              case_sensitive = true
              negate         = false
              operator       = "EQUALS"
              value          = "PERF_CFT"
            },
            key = {
              type      = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
          },
          {
            process_metadata = {
              attribute   = "PROCESS_GROUP_PREDEFINED_METADATA"
              dynamic_key = "KUBERNETES_NAMESPACE"
            },
            string = {
              case_sensitive = true
              negate         = false
              operator       = "CONTAINS"
              value          = "nfdiv"
            }
          }
        ]
      }
    ]
  },
  {
    name = "SVCOFF"
    rules = [
      {
        type    = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
              }
            }
          },
        ]
      },
      {
        type    = "PROCESS_GROUP"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
              }
            }
          }
        ]
      },
      {
        type    = "HOST"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
              }
            }
          }
        ]
      },
      {
        type    = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "WEB_APPLICATION_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
              }
            }
          }
        ]
      },
      {
        type    = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type      = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
              }
            }
          }
        ]
      },
      {
        type    = "AZURE"
        enabled = true
        conditions = [
          {
            indexed_tag = {
              negate   = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key     = "SVCOFF"
              }
            },
            key = {
              type      = "STATIC"
              attribute = "AZURE_ENTITY_TAGS"
            }
          }
        ]
      }
    ]
  }
]

dashboards = [
  {
    name   = "Platform Ops Oncall Dashboard"
    owner  = "chris.orisawayi@hmcts.net"
    shared = true
    tiles = [
      {
        name       = "Markdown"
        configured = true
        markdown   = "### CCD Case Management\n\n\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 0
            top    = 722
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-77E3F438670CBB8C"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 0
            top    = 760
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "###IDAM \n\n\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 304
            top    = 722
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-259E11691F39FF07"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 304
            top    = 760
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Appeal Benefit Decision (SSCS)\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 608
            top    = 722
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-8145F12E5FA9E7F8"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 608
            top    = 760
            width  = 304
          }
        ]
      },
      {
        name       = "Custom chart"
        configured = true
        tile_type  = "CUSTOM_CHARTING"
        bounds = [
          {
            height = 304
            left   = 0
            top    = 380
            width  = 304
          }
        ]
        filter = [
          {
            timeframe = "-1h"
          }
        ]
        filter_config = [
          {
            type         = "MIXED"
            custom_name  = "Availability rate [HTTP monitor]"
            default_name = "Custom chart"
            chart_config = [
              {
                type   = "TOP_LIST"
                legend = true
                series = [
                  {
                    type             = "LINE"
                    aggregation      = "AVG"
                    aggregation_rate = "TOTAL"
                    entity_type      = "SYNTHETIC_HTTPCHECK"
                    metric           = "builtin:synthetic.http.availability.location.total"
                    sort_ascending   = false
                    sort_column      = true
                    dimension = [
                      {
                        name             = "dt.entity.http_check"
                        entity_dimension = true
                        id               = "0"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "## CFT Availability\n\t\nAvailability for monitored CFT services\n\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 76
            left   = 0
            top    = 0
            width  = 1520
          }
        ]
        filter = [
          {
            timeframe = "Last 2 hours"
          }
        ]
      },
      {
        name          = "Synthetic monitor health"
        chart_visible = true
        configured    = true
        tile_type     = "SYNTHETIC_TESTS"
        bounds = [
          {
            height = 304
            left   = 0
            top    = 76
            width  = 1520
          }
        ]
        filter = [
          {
            timeframe = "-30m"
          }
        ]
      },
      {
        name       = ""
        configured = true
        tile_type  = "CUSTOM_CHARTING"
        bounds = [
          {
            height = 304
            left   = 304
            top    = 380
            width  = 418
          }
        ]
        filter = [
          {
            timeframe = "-1h"
            management_zone = [
              {
                name = "CFT"
                id   = "-3702796490256613011"
              }
            ]
          }
        ]
        filter_config = [
          {
            type         = "MIXED"
            custom_name  = "Number of HTTP 5xx errors"
            default_name = "Custom chart"
            chart_config = [
              {
                type   = "TIMESERIES"
                legend = true
                series = [
                  {
                    type             = "BAR"
                    aggregation      = "NONE"
                    aggregation_rate = "SECOND"
                    entity_type      = "SERVICE"
                    metric           = "builtin:service.errors.fivexx.count"
                    sort_ascending   = false
                    sort_column      = true
                    dimension = [
                      {
                        name             = "dt.entity.service"
                        entity_dimension = true
                        id               = "0"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        name       = ""
        configured = true
        tile_type  = "CUSTOM_CHARTING"
        bounds = [
          {
            height = 304
            left   = 722
            top    = 380
            width  = 380
          }
        ]
        filter = [
          {
            timeframe = "-1h"
            management_zone = [
              {
                name = "CFT"
                id   = "-3702796490256613011"
              }
            ]
          }
        ]
        filter_config = [
          {
            type         = "MIXED"
            custom_name  = "Number of HTTP 4xx errors"
            default_name = "Custom chart"
            chart_config = [
              {
                type   = "TIMESERIES"
                legend = true
                series = [
                  {
                    type             = "BAR"
                    aggregation      = "NONE"
                    aggregation_rate = "SECOND"
                    entity_type      = "SERVICE"
                    metric           = "builtin:service.errors.fourxx.count"
                    sort_ascending   = false
                    sort_column      = true
                    dimension = [
                      {
                        name             = "dt.entity.service"
                        entity_dimension = true
                        id               = "0"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-F0B7C9875F71D641"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 912
            top    = 760
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Apply for Probate\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 912
            top    = 722
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-75D2124FEFFE7F02"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 1216
            top    = 760
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Bulk Print - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 1216
            top    = 722
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Bulk Scan (orchestrator) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 0
            top    = 1102
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-271DB52DAFA31C3A"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 0
            top    = 1140
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Bulk Scan (payment-processor) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 304
            top    = 1102
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-D8891F77F743DC94"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 304
            top    = 1140
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-EE04B3A62997806B"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 608
            top    = 1140
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Bulk Scan (processor) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 608
            top    = 1102
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-14107C2B70F7405A"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 912
            top    = 1140
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Bulk Scan (reform-scan-notification-service) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 912
            top    = 1102
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-830532CC9D2DCF38"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 1216
            top    = 1140
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### CCD Platform (Private)\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 1216
            top    = 1102
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-DCB5E0A46A90EDCF"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 0
            top    = 1520
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### ccd-api-gateway-web Prod Health\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 0
            top    = 1482
            width  = 304
          }
        ]
      },
      {
        name        = "HTTP 5xx Errors - Count"
        configured  = true
        custom_name = "Data explorer results"
        tile_type   = "DATA_EXPLORER"
        unknowns    = "{\"queries\":[{\"enabled\":true,\"id\":\"A\",\"metric\":\"builtin:service.errors.fivexx.rate\",\"spaceAggregation\":\"COUNT\",\"timeAggregation\":\"DEFAULT\"}],\"visualConfig\":{\"axes\":{\"xAxis\":{\"visible\":true},\"yAxes\":[]},\"global\":{\"seriesType\":\"LINE\",\"theme\":\"DEFAULT\",\"threshold\":{\"axisTarget\":\"LEFT\",\"columnId\":\"Number of HTTP 5xx errors\",\"rules\":[{\"color\":\"#7dc540\"},{\"color\":\"#f5d30f\"},{\"color\":\"#dc172a\"}]}},\"rules\":[{\"matcher\":\"A:\",\"properties\":{\"color\":\"DEFAULT\",\"seriesType\":\"COLUMN\"}}],\"type\":\"GRAPH_CHART\"}}"
        bounds = [
          {
            height = 304
            left   = 1102
            top    = 380
            width  = 418
          }
        ]
        filter = [
          {
            timeframe = "-6h"
            management_zone = [
              {
                name = "CFT"
                id   = "-3702796490256613011"
              }
            ]
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-813F1EF87038E3A8"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 912
            top    = 1520
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-C316F569F3202D13"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 1216
            top    = 1520
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-7BCA00F009794800"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 0
            top    = 1900
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-9C7C4001CAA63CCB"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 304
            top    = 1520
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-6C9CD3F575DE727C"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 608
            top    = 1520
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### CVP - Availability\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 304
            top    = 1482
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### CVP - Availability (Admin Login URL)\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 608
            top    = 1482
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### CVP_Test_Call_Availability\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 912
            top    = 1482
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Divorce (Apply) - Availability\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 1216
            top    = 1482
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Divorce (DA) - Availability\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 0
            top    = 1862
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-9FA0B1BE744E11F1"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 304
            top    = 1900
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Divorce (DN) - Availability\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 304
            top    = 1862
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-8CEC7147F89D5334"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 608
            top    = 1900
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Divorce (RFE) - Availability\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 608
            top    = 1862
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-3B40C9FC89F82AE0"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 912
            top    = 1900
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-79E9A39242A3CD26"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 304
            top    = 2280
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-F74D2890A8C306F4"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 608
            top    = 2280
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-566A07BA5A947163"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 1216
            top    = 1900
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-BF8F9B3B36811585"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 0
            top    = 2280
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-136E443E1F560BEE"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 912
            top    = 2280
            width  = 304
          }
        ]
      },
      {
        name              = "HTTP monitor"
        assigned_entities = ["HTTP_CHECK-06C0517B2B83FF96"]
        configured        = true
        tile_type         = "SYNTHETIC_HTTP_MONITOR"
        bounds = [
          {
            height = 304
            left   = 1216
            top    = 2280
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Evidence Management (em-anno) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 0
            top    = 2242
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Evidence Management (em-hrs-api) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 304
            top    = 2242
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Employment Tribunal - Availability\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 912
            top    = 1862
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Evidence Management (dm-store) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 1216
            top    = 1862
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Evidence Management (em-icp) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 608
            top    = 2242
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Evidence Management (em-npa) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 912
            top    = 2242
            width  = 304
          }
        ]
      },
      {
        name       = "Markdown"
        configured = true
        markdown   = "### Evidence Management (em-orchestrator) - Private\n"
        tile_type  = "MARKDOWN"
        bounds = [
          {
            height = 38
            left   = 1216
            top    = 2242
            width  = 304
          }
        ]
      }
    ]
  }
]



