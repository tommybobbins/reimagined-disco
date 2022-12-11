# terraform nightly shutdown worked example

Create a secret.tfvars file containing something similar to the following:

```
credentials_file  = "wibbly-flibble-stuff-morestuff.json"
project           = "wibble-flibble-numbers"
region            = "europe-west2"
project_lifecycle = "development"
```

Create the   wibbly-flibble-stuff-morestuff.json from 
$ gcloud iam service-accounts keys create wibbly-flibble-stuff-morestuff.json \
    --iam-account=SA_NAME@PROJECT_ID.iam.gserviceaccount.com 

##
If the TF_VAR_project_lifecycle variable is set to live, then the powersaving is disabled (by default). If the TF_VAR_project_lifecycle is set to development, then the powersaving is enabled.

$ terraform init -var-file=secret.tfvars
$ terraform plan -var-file=secret.tfvars
$ terraform apply -var-file=secret.tfvars
