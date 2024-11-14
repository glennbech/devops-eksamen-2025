import json
import boto3
import requests
import os
import base64
import random

#config
bedrock_client = boto3.client("bedrock-runtime", region_name="us-east-1")
s3_client = boto3.client("s3")

#env variables
bucket_name = os.getenv("BUCKET_NAME")
prefix = "45"

#lambda function
def lambda_handler(event, context):
    #try to get the prompt from the request body
    try:
        
        body = json.loads(event["body"])
        prompt = body.get("prompt", "no prompt: generate a flying mouse in new york")

    except Exception as error:
        return {
            "statusCode": 400,
            "body": json.dumps(str(error))
        }

    #add a path to genererated image
    seed = random.randint(0, 2147483647)
    s3_image_path = f"{prefix}/generated_images/image_titan{seed}.png"

    native_request = {
        "taskType": "TEXT_IMAGE",
        "textToImageParams": {"text": prompt},
        "imageGenerationConfig": {
            "numberOfImages": 1,
            "quality": "standard",
            "cfgScale": 8.0,
            "height": 1024,
            "width": 1024,
            "seed": seed,
        }
    }

    try:
        #try to generate ai image
        response = bedrock_client.invoke_model(modelId="amazon.titan-image-generator-v1", body=json.dumps(native_request))
        model_response = json.loads(response["body"].read())

        base64_image_data = model_response["images"][0]
        image_data = base64.b64decode(base64_image_data)
        
        #putting the image into the s3 bucket
        s3_client.put_object(Bucket=bucket_name, Key=s3_image_path, Body=image_data)

        return {
            "statusCode": 200,
            "body": json.dumps({"message": f"Successfully generated and uploaded to s3 bucket: {bucket_name}", 
            "s3_path": f"image_path: {bucket_name}/{s3_image_path}"})
        }

    except Exception as error:
        return {
            "statusCode": 500,
            "body": json.dumps({str(error)})
        }