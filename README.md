# Dynatrace-Automation
Automation for dynatrace components such synthetic monitoring, dashboards, maintenance windows

## Automation pipeline
Located in [Azure DevOps pipelines](https://dev.azure.com/hmcts/PlatformOperations/_build?definitionId=495&_a=summary)

## Supported Features
The following features are currently supported by automation:
* Management zone
* Maintenance window
* Synthetic monitor (HTTP only)
* Synthetic location

## Supported Environments
* Nonprod (stg) 
  
Automation of the production environment is yet to be agreed with the [APM team](https://tools.hmcts.net/confluence/display/APM/Roles+and+Responsibilities).

## Infrastructure as Code Support Matrix
Current automation uses a combination of Terraform and [Monaco](https://dynatrace-oss.github.io/dynatrace-monitoring-as-code/).  Whilst Terraform is the automation tool of choice, some configuration settings are not currently supported by the [Dynatrace Terraform provider](https://github.com/dynatrace-oss/terraform-provider-dynatrace#currently-supported-configuration-settings) and are written in Monaco.  These will be moved over to Terraform once support becomes available.  Upcoming support are detailed in the [provider](https://github.com/dynatrace-oss/terraform-provider-dynatrace/issues/13) roadmap.
   
|Setting|Terraform|Monaco|
|:---|:---|:---|
|Synthetic monitor|  |:white_check_mark:|
|Synthetic location|  |:white_check_mark:|
|Maintenance Zone|:white_check_mark:| |
|Maintenance Window|:white_check_mark:| |
|Dashboard|:white_check_mark:| |

## Making changes

### Synthetic monitors
There is a master json template each for [public](https://github.com/hmcts/dynatrace-automation/blob/master/config/synthetic-monitor-public.json) and [private](https://github.com/hmcts/dynatrace-automation/blob/master/config/synthetic-monitor-private.json) synthetic monitors.
   
* Locate the environment values yaml file
* Add an entry in the config section in the format below
```yaml
config:
- apply-for-probate: "../../../config/synthetic-monitor-private.json"
  bulk-print-private: "../../../config/synthetic-monitor-private.json"
  new-config-name: "../../../config/synthetic-monitor-private.json"
```
* Below the config section, add an entry for the new monitor and provide the config values
```yaml
new-config-name:
  - name: "Monitor name"
    enabled: "false"
    description: "Monitor description"
    url: "https://targeturl"
    skipDeployment: "false"
```
* **Note:** Locations are hardcoded into the json template based on the [Synthetic Monitoring Strategy](https://tools.hmcts.net/confluence/display/APM/Synthetic+Monitoring+Strategy)
  * Public: London and Cardiff Azure
  * Private: Birmingham CTSC

### Maintenance Window
* Locate the environment [tfvars file](https://github.com/hmcts/dynatrace-automation/blob/master/environments/stg/stg.tfvars)
* Add a block entry in the maintenance window list as below
```terraform
maintenance_windows = [
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
  }
]
```
* > **Note**: After a configured maintenance window scheduled has elapsed, raise a PR to remove the maintenance window entry from code.  Maintenance window will be removed from Dynatrace on PR merge
* Refer to the [Terraform provider documentation](https://registry.terraform.io/providers/dynatrace-oss/dynatrace/latest/docs/resources/maintenance_window) for further information on config values
* Further information can also be found on the [APM maintenance window page](https://tools.hmcts.net/confluence/display/APM/Maintenance+Windows)
