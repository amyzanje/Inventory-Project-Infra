import boto3
import time
import openpyxl
import io
import os
from openpyxl import Workbook, load_workbook

def lambda_handler(event, context):
    
    # Env variables
        
    bucket_name = os.environ['bucket_name']
    file_name = os.environ['file_name']   
    
    #print(event)
    detail=event['detail']
    if 'eventName' in detail:
            event_name = event['detail']['eventName']
           
    elif 'event' in detail:  # There is an issue here
            event_name = event['detail']['event']

    print(event_name)
        
    if event_name in ['RunInstances']:
        time.sleep(45)
        
        # Extracting instance_id & instance_state from event json
        instance_id = event['detail']['responseElements']['instancesSet']['items'][0]['instanceId']
        instance_state = event['detail']['responseElements']['instancesSet']['items'][0]['instanceState']['name']
    
         
        
        # Download file
    
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        for item in contents:
            print(f"Ec2:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['EC2']
        #sheet.append(["Instance ID", "Instance State"])
        sheet.append([instance_id, instance_state])
    
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("Ec2 Details updaed.")

        return {
            "statusCode": 200,
            "body": "EC2 inventory details have been saved to S3 in Excel format.."
        }
        
        
        ###############################################################################################################################
        #                              Code for  ELB                                                                                  #
        ###############################################################################################################################
    
    elif event_name in ['CreateLoadBalancer']:
        # Extracting LB Details from event json
        print(event)
        
        loadBalancerName = event['detail']['requestParameters']['name']
        loadBalancerDNSName = event['detail']['responseElements']['loadBalancers'][0]['dNSName']
        
        print(loadBalancerName)
        print(loadBalancerDNSName)
        
        # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        # for item in contents:
        #     print(item)
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['ELB']
        
        sheet.append([loadBalancerName, loadBalancerDNSName])
    
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("ELB Details updaed.")

        return {
            "statusCode": 200,
            "body": "ELB inventory details have been saved to S3 in Excel format.."
        }

################################################## Code for Createvolume event ###########################################################        
        
        
    elif event_name in ['createVolume']:
        # Extracting LB Details from event json
        print(event)
        
        volume_arn = event['resources'][0]
        volume_id = volume_arn.split(":")
        volume_id= volume_id[-1]
        volume_id= volume_id.split("/")
        volume_id= volume_id[-1]
        print(volume_id)
        
        
        # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        for item in contents:
            print(f"Volume:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['Volume']
        sheet.append([volume_id])
    
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("Volume Details updaed.")

        return {
            "statusCode": 200,
            "body": "Volume inventory details have been saved to S3 in Excel format.."
        }
        
    
    ############################################ Code for EIP ####################################################
    
    elif event_name in ['AllocateAddress']:
        
        Public_IP= event['detail']['responseElements']['publicIp']
        
         # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        for item in contents:
            print(f"EIP:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['EIP']
        #sheet.append(["Instance ID", "Instance State"])
        sheet.append([Public_IP])
        
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("EIP Details updaed.")

        return {
            "statusCode": 200,
            "body": "EIP inventory details have been saved to S3 in Excel format.."
        }
        
######################################### Code for S3 Bucket Creation ##########################################

    elif event_name in ['CreateBucket']:
        
        new_bucket_name= event['detail']['requestParameters']['bucketName']
        print(new_bucket_name)
        
         # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        for item in contents:
            print(f"S3:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['S3']
        sheet.append([new_bucket_name])
        
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("S3 Bucket Details updaed.")

        return {
            "statusCode": 200,
            "body": "S3 Bucket inventory details have been saved to S3 in Excel format.."
        }
        
######################################### Code for Key Pair Creation ##########################################
    
    elif event_name in ['CreateKeyPair']:
        
        keyname= event['detail']['requestParameters']['keyName']
        keytype= event['detail']['requestParameters']['keyType']
        keyformat= event['detail']['requestParameters']['keyFormat']
        
        
         # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        for item in contents:
            print(f"KeyPair:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['KeyPair']
        sheet.append([keyname, keytype, keyformat])
        
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("S3 Bucket Details updaed.")

        return {
            "statusCode": 200,
            "body": "Key Pair inventory details have been saved to S3 in Excel format.."
        }
    
    ##################################################### Code for IAM Users ##################################################
    
    elif event_name in ['CreateUser']:
        
        user= event['detail']['requestParameters']['userName']
        
         # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        # for item in contents:
        #     print(f"KeyPair:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['IAM_User']
        sheet.append([user])
        
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("User  Details updaed.")

        return {
            "statusCode": 200,
            "body": "User inventory details have been saved to S3 in Excel format.."
        }
    
    ######################################################## Code for RDS ###################################################
    
    elif event_name in ['CreateDBInstance']:
        
        db_id= event['detail']['requestParameters']['dBInstanceIdentifier']
        
         # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        # for item in contents:
        #     print(f"KeyPair:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['RDS']
        sheet.append([db_id])
        
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("User  Details updaed.")

        return {
            "statusCode": 200,
            "body": "User inventory details have been saved to S3 in Excel format.."
        }
    
    
    ################################################################## Code for SG #################################################
    
    elif event_name in ['CreateSecurityGroup']:
        
        sg_id= event['detail']['responseElements']['groupId']
        
         # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        # for item in contents:
        #     print(f"KeyPair:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['SG']
        sheet.append([sg_id])
        
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("User  Details updaed.")

        return {
            "statusCode": 200,
            "body": "User inventory details have been saved to S3 in Excel format.."
        }
        
        
        
    ################################ Create DB Cluster ################################################
    
    
    elif event_name in ['CreateDBCluster']:
        
        cluster_id= event['detail']['responseElements']['dBClusterIdentifier']
        
         # Download file
        s3 = boto3.resource("s3")
        bucket = s3.Bucket(bucket_name)
        File_name_on_S3 = file_name
        File_name_locally = "/tmp/ec2_inventory_local1.xlsx"  # Download to /tmp directory

        bucket.download_file(Key=File_name_on_S3, Filename=File_name_locally)

        contents = os.listdir("/tmp")
        # for item in contents:
        #     print(f"KeyPair:{item}")
    
        workbook = load_workbook("/tmp/ec2_inventory_local1.xlsx")
        sheet = workbook['DB-Cluster']
        sheet.append([cluster_id])
        
        # Save Excel file in memory
        excel_file = io.BytesIO()
        workbook.save(excel_file)
        excel_file.seek(0)

        # Upload the Excel file to the S3 bucket
        bucket_name = bucket_name  # Replace with your S3 bucket name
        s3_client = boto3.client('s3')
        s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=excel_file)
        print("Cluster Details updaed.")

        return {
            "statusCode": 200,
            "body": "Cluster inventory details have been saved to S3 in Excel format.."
        }
    
    
    
    
    
    ##################################################################################################################
    else:
        return {
            'statusCode': 400,
            'body': 'Event not supported: {}'.format(event_name)
        }
        
    return {
        "statusCode": 200, 
        "body": "Instance status check completed" 
    }