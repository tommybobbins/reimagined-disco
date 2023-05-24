# Implement Powersaving on GCP Compute Instances

## Terraform nightly shutdown using Instance Schedules worked example

Create a secret.tfvars file containing something similar to the following:

```
credentials_file  = "wibbly-flibble-stuff-morestuff.json"
project           = "wibble-flibble-numbers"
region            = "europe-west2"
project_lifecycle = "development"
```

Create the  service account keys which will be used for terraform wibbly-flibble-stuff-morestuff.json using:
```
$ gcloud iam service-accounts keys create wibbly-flibble-stuff-morestuff.json \
    --iam-account=SA_NAME@PROJECT_ID.iam.gserviceaccount.com 
```
##
If the TF_VAR_project_lifecycle variable is set to live, then the powersaving is disabled (by default). If the TF_VAR_project_lifecycle is set to development, then the powersaving is enabled.

```
$ terraform init -var-file=secret.tfvars
$ terraform plan -var-file=secret.tfvars
$ terraform apply -var-file=secret.tfvars
```

```
$ gcloud services list --enabled
NAME                                 TITLE
appengine.googleapis.com             App Engine Admin API
bigquery.googleapis.com              BigQuery API
bigquerystorage.googleapis.com       BigQuery Storage API
cloudapis.googleapis.com             Google Cloud APIs
cloudbuild.googleapis.com            Cloud Build API
clouddebugger.googleapis.com         Cloud Debugger API
cloudfunctions.googleapis.com        Cloud Functions API
cloudresourcemanager.googleapis.com  Cloud Resource Manager API
cloudscheduler.googleapis.com        Cloud Scheduler API
cloudtrace.googleapis.com            Cloud Trace API
compute.googleapis.com               Compute Engine API
container.googleapis.com             Kubernetes Engine API
containerregistry.googleapis.com     Container Registry API
datastore.googleapis.com             Cloud Datastore API
deploymentmanager.googleapis.com     Cloud Deployment Manager V2 API
iam.googleapis.com                   Identity and Access Management (IAM) API
iamcredentials.googleapis.com        IAM Service Account Credentials API
logging.googleapis.com               Cloud Logging API
monitoring.googleapis.com            Cloud Monitoring API
oslogin.googleapis.com               Cloud OS Login API
pubsub.googleapis.com                Cloud Pub/Sub API
servicemanagement.googleapis.com     Service Management API
serviceusage.googleapis.com          Service Usage API
source.googleapis.com                Legacy Cloud Source Repositories API
sourcerepo.googleapis.com            Cloud Source Repositories API
sql-component.googleapis.com         Cloud SQL
storage-api.googleapis.com           Google Cloud Storage JSON API
storage-component.googleapis.com     Cloud Storage
storage.googleapis.com               Cloud Storage API
```
