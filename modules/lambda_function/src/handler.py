import boto3
from PIL import Image
import os
import tempfile

s3 = boto3.client('s3')

def lambda_handler(event, context):
    src_bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    dst_bucket = os.environ['DEST_BUCKET']

    with tempfile.TemporaryDirectory() as tmpdir:
        src_path = os.path.join(tmpdir, "original.jpg")
        dst_path = os.path.join(tmpdir, "stripped.jpg")

        s3.download_file(src_bucket, key, src_path)

        img = Image.open(src_path)
        img.save(dst_path, "JPEG", exif=b"")

        s3.upload_file(dst_path, dst_bucket, key)

    return {"statusCode": 200}
