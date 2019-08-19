"""
    Iterates over images with the tag "Family"
    Only keeps X number of images and deletes the rest
"""
import boto3
import logging
import sys
import os
from datetime import datetime

logger = logging.getLogger(__name__)

def handler(event, context):
    logging.basicConfig(
        level=logging.INFO,
        format="{'time':'%(asctime)s','lvl': '%(levelname)s', 'msg':'%(message)s'}"
    )
        
    try:
        image_family = str(os.environ['family'])
        images_to_keep = int(os.environ['keep'])
    except Exception:
        logger.error("Missing or invalid environment variables")
        sys.exit(1)
    
    images = get_images(image_family)
    images = sort_images(images)
    
    logger.info(f"Found {len(images)} images")
    
    if len(images) < images_to_keep:
        logger.info("No images found to delete")
        sys.exit(0)
        
    for image in images[images_to_keep:]:
        delete_image(image)


def delete_image(image):
    ec2 = boto3.client('ec2')
    logger.info(f"Deleting {image['ImageId']}")
    response = ec2.deregister_image(ImageId=image['ImageId'])
    exit_on_error(response)


def sort_images(images):
    for image in images:
        image['Datetime'] = datetime.strptime(image['CreationDate'], "%Y-%m-%dT%H:%M:%S.%fZ")
    
    images.sort(key=lambda i: i['Datetime'])
    return images


def get_images(family):
    ec2 = boto3.client('ec2')
    response = ec2.describe_images(
        Filters=[
            {
                'Name':'tag:Family',
                'Values':[family]
            }
        ]
    )
    exit_on_error(response)
    return response['Images']


def exit_on_error(boto_response):
    status_code = boto_response['ResponseMetadata']['HTTPStatusCode']
    request_id = boto_response['ResponseMetadata']['RequestId']

    if status_code != 200:
        logger.critical(f"AWS response failed with HTTP {status_code}! RequestId: {request_id}")
        sys.exit(1)


if __name__ == '__main__':
    handler(None, None)
