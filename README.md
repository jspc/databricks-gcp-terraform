# Databricks on GCP

This repository prepares a GCP project for peering with Databricks, and then configures a Databricks workspace.

## Configuration

The terraform in this repository can be configured using the following variables:

| Variable | Description | Type | Default |
|---|---|---|---|
| `google_project` | The project, in GCP, to deploy Databricks with | `string` | `techtest-403409` |
| `region` | The GCP region in which to deploy | `string` | `europe-west2` |
| `backend_rest_psce` | The name to give to the Private Service Connect Endpoint for the backend rest API | `string` | `databricks_rest` |
| `relay_psce` | The name to give to the Private Service Connect Endpoint for the relay API  | `string` | `databricks_relay` |
| `databricks_account_id` | The ID for your Databricks account (see: [here](https://docs.databricks.com/en/administration-guide/account-settings/index.html) for more information) | `string` | `` |
| `databricks_google_service_account` | The GCP IAM service account which has access to Databricks (see [here]() for more information) | `string` | `` |


These may be specified on the command line, during `terraform plan` and/or `terraform apply`, via the flag `-var databricks_account_id=foo` (etc.).

They may also be specified in environment variables with the format: `export TF_VAR_databricks_account_id=foo` (note the capitalisation of `TF_VAR`)


## Deployment

This project uses Github Actions to deploy. The workflow is defined in [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

This workflow uses [Workload Identity Federation](https://github.com/google-github-actions/auth) to deploy from Github Actions into GCP; forking this repository will require the same thing being configured.
