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
            negate = false
            operator = "EQUALS"
            value = {
              context = "CONTEXTLESS"
              key = "Department"
              value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "am"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "am "
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
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "am"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "am "
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
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "bsp"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "scan"
            }
          },
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "reform-scan"
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            process_metadata = {
            attribute = "PROCESS_GROUP_PREDEFINED_METADATA"
            dynamic_key = "KUBERNETES_FULL_POD_NAME"
            },
            string = {
            case_sensitive = true
            negate = false
            operator = "BEGINS_WITH"
            value = "rpe-send-letter"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            }
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "send_letter"
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
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            process_metadata = {
              attribute = "PROCESS_GROUP_PREDEFINED_METADATA"
              dynamic_key = "KUBERNETES_FULL_POD_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "rpe-send-letter"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            }
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "send_letter"
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
        type = "PROCESS_GROUP"
        enabled = false
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ccd"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "CCD"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "perf"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ccd "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ccd"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "health"
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
        type = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ccd "
              }
            }
          },
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "ccd"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "aat"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = false
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ccd "
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ccd"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = true
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = true
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "LDATA"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001306"
              }
            }
          },
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001306"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001306"
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
        type = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "cmc "
              }
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "money-claims"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Civil Money Claims"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "money-claims"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001246"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001246"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001246"
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
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "unspec"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Camun"
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Manag"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "cmc "
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "divorce"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "div "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = false
              negate = false
              operator = "EQUALS"
              value = "CFT Divorce Perf Test"
            }
          },
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001242"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001242"
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
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "div "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "EQUALS"
              value = "cft divorce staging"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "divorce"
              }
            }
          },
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001242"
            }
      }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001242"
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
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "EQUALS"
              value = "CFT Divorce AAT"
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
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "EQUALS"
              value = "CFT Divorce Demo"
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ethos"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "LDATA"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "ecm"
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "CFT CCD"
            }
          },
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "CFT XUI"
            }
          },
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ethos"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TECHNOLOGY"
            },
            tech = {
              negate = false
              operator = "EQUALS"
              value = {
                type = "ELASTIC_SEARCH"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ethosldata"
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ethos"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "ecm"
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "CFT CCD Perf"
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "CFT XUI"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ethos"
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_SERVICE",
          "PROCESS_GROUP_TO_HOST"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ethos"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "ecm"
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "CFT CCD"
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "CFT XUI"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ethos"
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "HOST_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "ccd-data"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = [
          "PROCESS_GROUP_TO_HOST",
          "PROCESS_GROUP_TO_SERVICE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "HOST_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "BEGINS_WITH"
              value = "ccd-data"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
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
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "em"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "em "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "dg"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            }
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "dm "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "dm-store"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
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
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "dm "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "em "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "em"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "dg"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "dm-store"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
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
        type = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "fpl "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Family Public Law - Perf"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = false
        propagation_types = [
          "PROCESS_GROUP_TO_SERVICE",
          "PROCESS_GROUP_TO_HOST"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "family-public-law"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001260"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_PROCESS_GROUP_LIKE",
          "SERVICE_TO_HOST_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001260"
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
        type = "SERVICE"
        enabled = false
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "fpl "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "family public law"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = false
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "family-public-law"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001260"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = [
          "SERVICE_TO_HOST_LIKE",
          "SERVICE_TO_PROCESS_GROUP_LIKE"
        ]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001260"
              }
            }
          }
        ]
      }
    ]
  },
  {
    name = "CFT - Fees \u0026 Payments - Perf"
    rules  = [
      {
        type = "SERVICE"
        enabled = false
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "payment "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "EQUALS"
              value = "CFT Fees \u0026 Payments - Perf"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "fees-pay"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = false
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "fees-pay"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "fees-pay"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "payment "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "fees "
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
        type = "SERVICE"
        enabled = false
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "payment "
              }
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "fees-pay"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "EQUALS"
              value = "CFT Fees \u0026 Payments - AAT"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = false
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "fees-pay"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001394"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "fees "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001394"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "payment "
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
        type = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Financial Remedy"
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "Finrem AAT"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "financial-remedy"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001258"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001258"
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
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "EQUALS"
              value = "CFT Finrem Demo"
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
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "EQUALS"
              value = "CFT Finrem ITHC"
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
        type = "SERVICE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Financial Remedy"
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Finrem Perf"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "financial-remedy"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001258"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001258"
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "HOST_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "forgerock"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "idam"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            }
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "idam "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "IDAM"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Perf"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Application"
                value = "IDAM"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_HOST_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "idam"
            }
          }
        ]
      },
      {
        type = "HOST"
        enabled = true
        conditions = [
          {
            string = {
              case_sensitive = true
              negate = false
              operator = "EQUALS"
              value = "PERF_CFT_IDAM"
            },
            key = {
              type = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "IDAM"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "idam "
              }
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE","PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "SANDBOX"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_HOST_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "idam"
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "idam "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "IDAM"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "AAT"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "idam"
              }
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Application"
                value = "IDAM"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_DATABASE_HOST_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "idam"
            }
          },
        ]
      },
      {
        type = "CLOUD_APPLICATION_NAMESPACE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "CLOUD_APPLICATION_NAMESPACE_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "EQUALS"
              value = "idam"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "aat"
            }
          }
        ]
      },
      {
        type = "HOST"
        enabled = true
        conditions = [
          {
            string = {
              case_sensitive = true
              negate = false
              operator = "EQUALS"
              value = "AAT_CFT_IDAM"
            },
            key = {
              type = "STATIC"
              attribute = "HOST_GROUP_NAME"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "IDAM"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "HOST_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ia "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            }
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Immigration and Asylum"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "Perf"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE","PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ia"
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ia "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "Immigration and Asylum"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "AAT"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "ia"
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE","PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "LDATA"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "ldata"
            }
          }
        ]
      },
      {
        type = "KUBERNETES_CLUSTER"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "cft-ldata"
            }
          }
        ]
      },
      {
        type = "AZURE"
        enabled = true
        propagation_types = ["AZURE_TO_PG","AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate = false
              operator = "CONTAINS"
              value = "DCD-ETHOS-MIGRATION-LDATA"
            },
            key = {
              type = "STATIC"
              attribute = "AZURE_ENTITY_NAME"
            }
          }
        ]
      },
      {
        type = "CLOUD_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "cft-ldata"
            }
          }
        ]
      },
      {
        type = "CLOUD_APPLICATION_NAMESPACE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "cft-ldata"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "cft-ldata"
            }
          }
        ]
      },
      {
        type = "HOST"
        enabled = true
        propagation_types = ["HOST_TO_PROCESS_GROUP_INSTANCE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "cft-ldata"
            }
          }
        ]
      },
      {
        type = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Palo Alto - LDATA"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ccd "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "idam "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "ethos"
              }
            }
          }
        ]
      },
      {
        type = "AZURE"
        enabled = true
        propagation_types = ["AZURE_TO_PG","AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Azure Entities"
                value = "CFT LDATA"
              }
            },
            key = {
              type = "STATIC"
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_SERVICE","PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "cmc-legal"
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
        type = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Palo Alto Non-Prod (Perf \u0026 LDATA)"
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "pcq"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "pcq "
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "pcq"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = true
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "health"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "pcq "
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
        type = "PROCESS_GROUP"
        enabled = true
        propagation_types = ["PROCESS_GROUP_TO_HOST","PROCESS_GROUP_TO_SERVICE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "perf"
            }
          }
        ]
      },
      {
        type = "KUBERNETES_CLUSTER"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "cft-perf"
            }
          }
        ]
      },
      {
        type = "AZURE"
        enabled = true
        propagation_types = ["AZURE_TO_PG","AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_name = {
              negate = false
              operator = "CONTAINS"
              value = "DCD-CFTAPPS-TEST"
            }
            key = {
              type = "STATIC"
              attribute = "AZURE_ENTITY_NAME"
            }
          }
        ]
      },
      {
        type = "CLOUD_APPLICATION"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "CONTAINS"
              value = "cft-perf"
            }
          }
        ]
      },
      {
        type = "CLOUD_APPLICATION_NAMESPACE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "cft-perf"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "cft-perf"
            }
          }
        ]
      },
      {
        type = "HOST"
        enabled = true
        propagation_types = ["HOST_TO_PROCESS_GROUP_INSTANCE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "KUBERNETES_CLUSTER_NAME"
            },
            string = {
              case_sensitive = false
              negate = false
              operator = "CONTAINS"
              value = "cft-perf"
            }
          }
        ]
      },
      {
        type = "CUSTOM_DEVICE"
        enabled = true
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "CUSTOM_DEVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "TAG_KEY_EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Palo Alto - PERF"
              }
            }
          }
        ]
      },
      {
        type = "AZURE"
        enabled = true
        propagation_types = ["AZURE_TO_PG","AZURE_TO_SERVICE"]
        conditions = [
          {
            indexed_tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Azure Entities"
                value = "CFT Perf"
              }
            },
            key = {
              type = "STATIC"
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
        type = "PROCESS_GROUP"
        enabled = false
        propagation_types = ["PROCESS_GROUP_TO_SERVICE","PROCESS_GROUP_TO_HOST"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "probate"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "EQUALS"
              value = "CFT Probate - Perf"
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = false
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "probatemandb "
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = false
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "probate"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001244"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001244"
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
        type = "SERVICE"
        enabled = false
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "probatemandb "
              }
            }
          }
        ]
      },
      {
        type = "WEB_APPLICATION"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "WEB_APPLICATION_NAME"
            },
            string = {
              case_sensitive = true
              negate = false
              operator = "EQUALS"
              value = "CFT Probate - AAT"
            }
          }
        ]
      },
      {
        type = "PROCESS_GROUP"
        enabled = false
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "PROCESS_GROUP_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "probate"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = false
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "probate"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001244"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "SVCOFF"
                value = "SVCOFF0001244"
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
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "PERF"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "rd"
              }
            }
          },
          {
            type = "SERVICE"
            enabled = true
            propagation_types = ["SERVICE_TO_HOST_LIKE","SERVICE_TO_PROCESS_GROUP_LIKE"]
            conditions = [
              {
                key = {
                  type = "STATIC"
                  attribute = "SERVICE_TYPE"
                },
                service_type = {
                  negate = false
                  operator = "EQUALS"
                  value = "DATABASE_SERVICE"
                }
              },
              {
                key = {
                  type = "STATIC"
                  attribute = "SERVICE_TAGS"
                },
                tag = {
                  negate = false
                  operator = "EQUALS"
                  value = {
                    context = "CONTEXTLESS"
                    key = "CFT Database"
                    value = "rd "
                  }
                }
              }
            ]
          }

        ]
      }
    ]
  },
  {
    name = "CFT - Professional Reference Data - Staging"
    rules = [
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Environment"
                value = "AAT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "NS"
                value = "rd"
              }
            }
          }
        ]
      },
      {
        type = "SERVICE"
        enabled = true
        propagation_types = ["SERVICE_TO_PROCESS_GROUP_LIKE","SERVICE_TO_HOST_LIKE"]
        conditions = [
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TYPE"
            },
            service_type = {
              negate = false
              operator = "EQUALS"
              value = "DATABASE_SERVICE"
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "Department"
                value = "CFT"
              }
            }
          },
          {
            key = {
              type = "STATIC"
              attribute = "SERVICE_TAGS"
            },
            tag = {
              negate = false
              operator = "EQUALS"
              value = {
                context = "CONTEXTLESS"
                key = "CFT Database"
                value = "rd "
              }
            }
          }
        ]
      }
    ]
  }
]


