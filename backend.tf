terraform {
  backend "gcs" {
    bucket  = "zi_techtest_terraform_state"
    prefix  = "databricks"
  }

  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
    google = {}
  }
}

provider "google" {
  project = var.google_project
  region  = var.region
}

provider "databricks" {
  alias                  = "accounts"
  host                   = "https://accounts.gcp.databricks.com"
  google_service_account = var.databricks_google_service_account
  account_id             = var.databricks_account_id
}

data "google_client_openid_userinfo" "me" {
}

data "google_client_config" "current" {
}
