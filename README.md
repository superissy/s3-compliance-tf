# S3 BUCKET NON-COMPLIANCE REMEDIATION
[Powered by Issy](https://)

#### This is an S3 Compliance-violation detection and remediation. This project is build with using Terraform which can allow IaC deployment.

#### Belows are detailed informations such as Archicture, Resources and Step by Step Deployment


> Architectural Workflow 
![image](https://user-images.githubusercontent.com/80710703/147922194-fbfb849f-ab8b-477f-a382-68f1d04f7c3e.png)
##### Image 0.1
> A curated list of S3 bucket Config Rules 
* s3-bucket-logging-enabled
* s3-bucket-server-side-encryption-enabled
* s3-bucket-public-read-prohibited
* s3-bucket-public-write-prohibited

> Resources 
* Config Rule
* S3 Buckets
* IAM Policy & Role
* Lambda Function
* SNS Notification
