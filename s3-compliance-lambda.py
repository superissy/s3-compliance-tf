# For every unencrypted & therefore non compliant s3 bucket reported by the aws config rule s3-bucket-server-side-encryption-enabled
# this script will make them compliant and 
# send an SNS notification with informing a preferred target about what buckets have been remediated

#imports
import json
import boto3

#resource clients
config_client = boto3.client('config')
s3_client = boto3.client('s3')
sns_client = boto3.client('sns')


def lambda_handler(event, context):
    #get the non-compliant results of the config rule evaluation
    config_response = config_client.get_compliance_details_by_config_rule(
        ConfigRuleName='s3-bucket-server-side-encryption-enabled',
        ComplianceTypes=['NON_COMPLIANT']
    )
    #json dump to convert from datetime to serialised string response
    config_response = json.loads(json.dumps(config_response, default=str))

    #filter response (a dictionary) to get only the info about compliant resources
    config_response = config_response['EvaluationResults']

    #if there are noncompliant buckets
    if config_response != [] :
        resource_ids = []       #list to hold resouuce ids

        #filter response (a dictionary) to get only the ResourceIDs of non-compliant s3 buckets
        for evaluation in config_response:
            #list to hold resouuce ids
            resource_ids.append(evaluation['EvaluationResultIdentifier']['EvaluationResultQualifier']['ResourceId'])

        #make the unencrypted buckets encrypted
        for id in resource_ids:
            s3_response = s3_client.put_bucket_encryption(
                Bucket=id,
                ServerSideEncryptionConfiguration={
                    'Rules': [
                        {
                            'ApplyServerSideEncryptionByDefault': {
                                'SSEAlgorithm': 'AES256'        
                            }
                        }
                    ]
                }
            )

        #send a message to the sns subscribers
        sns_response = sns_client.publish(
            TargetArn='enter sns arn here',
            Message='S3 bucket encryption is now remediated. The following bucket(s) are now encrypted ' + str(resource_ids),
            Subject='S3 bucket Encryption Remediated'
        )

        return 'Evaluation completed and Non-Compliance S3 Buckets Detected'
     else:
    #    # test message saying nothing to remediate send a message to the sns subscribers

         sns_response = sns_client.publish(
             TargetArn='enter sns arn here',
             Message='S3 bucket encryption is now remediated. The following buckets are now encrypted ' + str(resource_ids),
             Subject='S3 bucket Encryption Remediated'
         )

    #     return 'no errors, compliance remediated'


    



    
