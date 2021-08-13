# Dynatrace-Automation
Automation for dynatrace components such synthetic monitoring, dashboards, maintenance windows

## Supported Features
The following features are currently supported by automation:
Management zone
Maintenance window
Synthetic monitor (HTTP only)
Synthetic location

## Supported Environment
Nonprod(stg) environment only. 
Automation of the production environment is yet to be agreed with the [APM team](https://tools.hmcts.net/confluence/display/APM/Roles+and+Responsibilities).

## Infrastructure as Code Support Matrix
Current automation uses a combination of Terraform and [Monaco](https://dynatrace-oss.github.io/dynatrace-monitoring-as-code/).  Whilst Terraform is the automation tool of choice, some configuration settings are not currently supported by the [Dynatrace Terraform provider](https://github.com/dynatrace-oss/terraform-provider-dynatrace#currently-supported-configuration-settings) and are written in Monaco.  These will be moved over to Terraform once support becomes available.  Upcoming support are detailed in the [provider](https://github.com/dynatrace-oss/terraform-provider-dynatrace/issues/13) roadmap.
   
|Setting|Terraform|Monaco|
|-------|---------|------|
|Synthetic monitor|  |:white_check_mark:|
|Synthetic location|  |:white_check_mark:|
|Maintenance Zone|:white_check_mark:| |
|Maintenance Window|:white_check_mark:| |
|Dashboard|:white_check_mark:| |

## Usage