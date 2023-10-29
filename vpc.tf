resource "google_compute_network" "databricks" {
  project                 = var.google_project
  name                    = "databricks"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "databricks" {
  name          = "databricks-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.databricks.id

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "svc"
    ip_cidr_range = "10.2.0.0/20"
  }

  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.databricks.region
  network = google_compute_network.databricks.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
