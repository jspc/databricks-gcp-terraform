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
  description = ""
  type        = string
  default     = ""
}

variable "relay_psce" {
  description = ""
  type        = string
  default     = ""
}

variable "databricks_account_id" {
  description = "Account ID for Databricks"
  type        = string
  default     = "b0b424aa-a088-4285-86d1-163ee80bd2d1"
}

variable "databricks_google_service_account" {
  description = "GCP Service Account for provisioning Databricks resources"
  type        = string
  default     = ""
}
