# Terraform EKS deployment

## Description 
This repository contain all the necessary resources in order to deploy a full blown EKS cluster, additionally the repo also contain a GitHub Action CI/CD pipeline that is triggered on every commit

## Repo Content 
* terraform.yaml (pipeline) to build the cluster via a procedural pipeline.

* backend.tf to define the tfstate to be sent into an S3 bucket which was created seperately.

* eks_iam_roles.tf to configure all the necessary IAM roles for the eks cluster and nodegroup.

* main.tf to declare all the necessary resources that are needed.

* variables.tf for all the project variables, contain defintions for example; resource_type for ec2.