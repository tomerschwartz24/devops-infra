# Terraform EKS deployment

## Description 
This repository contain all the necessary resources in order to deploy a full blown EKS cluster, additionally the repo also contain a GitHub Action pipeline for the deployment.
## Repo Content 
* .github/workflows/terraform.yaml (pipeline) to build the cluster
* terraform folder contain the resources to build the EKS Cluster
* The terraform state file resides in a remote S3 backend in AWS
