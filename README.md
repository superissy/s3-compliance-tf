# S3 BUCKET NON-COMPLIANCE REMEDIATION
[Powered by Issy](https://)

#### This is an S3 Compliance-violation detection and remediation. This project is build with using Terraform which can allow IaC deployment.

#### Belows are detailed informations such as Archicture, Resources and Step by Step Deployment

> Architectural Workflow
> ![Architectural Workflow](https://github.com/superissy/s3-compliance-tf/blob/main/image/Blank%20diagram.png)
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

> REMEDIATE THE BUCKETS AND MAKE THEM ENCRYPTED
* Enter a new function name, select Python 3.8 as the runtime and hit the “Create Function” button.
* The code below imports json module which is used to convert python dictionary into JSON string. We also import the boto3 module to make calls to AWS APIs.
```
import json
import boto3
```

* We will be interacting with 3 AWS services which are AWS config, S3 and SNS. We pass the name of the services using the code below

```
config_client = boto3.client('config')
config_client1 = boto3.client('s3')
config_client2 = boto3.client('sns')
```

The Lambda function handler is the method in our function code that processes events. When our function is invoked, Lambda runs the handler method. The general syntax is shown below
```
def lambda_handler(event, context):
```
Use the code below to return the non_compliant/unencrypted buckets from AWS config

```
    response = config_client.get_compliance_details_by_config_rule(
    ConfigRuleName='s3-bucket-server-side-encryption-enabled',
    ComplianceTypes=['NON_COMPLIANT'],
    )
    non_compliant=json.loads(json.dumps(response, default=str))
```
