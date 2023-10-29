resource "databricks_mws_vpc_endpoint" "backend_rest_vpce" {
  account_id        = var.databricks_account_id
  vpc_endpoint_name = "vpce-backend-rest"

  gcp_vpc_endpoint_info {
    project_id        = var.google_project
    psc_endpoint_name = var.backend_rest_psce
    endpoint_region   = google_compute_subnetwork.databricks.region
  }
}

resource "databricks_mws_vpc_endpoint" "relay_vpce" {
  account_id        = var.databricks_account_id
  vpc_endpoint_name = "vpce-relay"

  gcp_vpc_endpoint_info {
    project_id        = var.google_project
    psc_endpoint_name = var.relay_psce
    endpoint_region   = google_compute_subnetwork.databricks.region
  }
}

resource "databricks_mws_networks" "this" {
  provider     = databricks.accounts
  account_id   = var.databricks_account_id
  network_name = "techtest"

  gcp_network_info {
    network_project_id    = var.google_project
    vpc_id                = google_compute_network.databricks.name
    subnet_id             = google_compute_subnetwork.databricks.name
    subnet_region         = google_compute_subnetwork.databricks.region

    pod_ip_range_name     = "pods"
    service_ip_range_name = "svc"
  }

  vpc_endpoints {
    dataplane_relay = [databricks_mws_vpc_endpoint.relay_vpce.vpc_endpoint_id]
    rest_api        = [databricks_mws_vpc_endpoint.backend_rest_vpce.vpc_endpoint_id]
  }
}

resource "databricks_mws_private_access_settings" "pas" {
  account_id                   = var.databricks_account_id
  private_access_settings_name = "pas-databricks"
  region                       = google_compute_subnetwork.databricks.region
  public_access_enabled        = true
  private_access_level         = "ACCOUNT"
}

resource "databricks_mws_workspaces" "this" {
  provider       = databricks.accounts
  account_id     = var.databricks_account_id
  workspace_name = "techtest"
  location       = google_compute_subnetwork.databricks.region

  cloud_resource_container {
    gcp {
      project_id = var.google_project
    }
  }

  private_access_settings_id = databricks_mws_private_access_settings.pas.private_access_settings_id
  network_id                 = databricks_mws_networks.this.network_id

  gke_config {
    connectivity_type = "PRIVATE_NODE_PUBLIC_MASTER"
    master_ip_range   = "10.3.0.0/28"
  }

  token {
    comment = "Terraform"
  }

  # this makes sure that the NAT is created for outbound traffic before creating the workspace
  depends_on = [google_compute_router_nat.nat]
}
