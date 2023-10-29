variable "google_project" {
  description = "Google project in which to deploy"
  type        = string
  default     = "techtest-403419"
}

variable "region" {
  description = "Region in which to deploy"
  type        = string
  default     = "europe-west2"
}

variable "backend_rest_psce" {
  type    = string
  default = "databricks_rest"
}

variable "relay_psce" {
  type    = string
  default = "databricks_relay"
}

variable "databricks_account_id" {
  description = "Account ID for Databricks"
  type        = string
  default     = ""
}

variable "databricks_google_service_account" {
  description = "GCP Service Account for provisioning Databricks resources"
  type        = string
  default     = ""
}
