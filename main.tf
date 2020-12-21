
variable "policyId" {}
variable "cpu_critical" { default=90 }
variable "cpu_warning" { default=80 }
variable "disk_percent" { default=75 }

resource "newrelic_infra_alert_condition" "CPUHot" {
  policy_id = var.policyId

  name       = "CPU Hot"
  type       = "infra_metric"
  event      = "SystemSample"
  select     = "cpuPercent"
  comparison = "above"
  where      = "(hostname LIKE '%myhost%')"

  critical {
    duration      = 5
    value         = var.cpu_critical
    time_function = "all"
  }

  warning {
    duration      = 5
    value         = var.cpu_warning
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "DiskHigh" {
  policy_id = var.policyId

  name       = "High disk usage"
  type       = "infra_metric"
  event      = "StorageSample"
  select     = "diskUsedPercent"
  comparison = "above"
  where      = "(hostname LIKE '%frontend%')"

  critical {
    duration      = 25
    value         = var.disk_percent
    time_function = "all"
  }

}
