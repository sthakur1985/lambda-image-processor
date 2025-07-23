# lambda-image-processor

Task1: A company allows their users to upload pictures to an S3 bucket. These pictures are always in the .jpg format.
The company wants these files to be stripped from any exif metadata before being shown on their website.
Pictures are uploaded to an S3 bucket A.
Create a system that retrieves .jpg files when they are uploaded to the S3 bucket A, removes any exif metadata,
and save them to another S3 bucket B. The path of the files should be the same in buckets A and B.
Task2: To extend this further, we have two users User A and User B. Create IAM users with the following access:
• User A can Read/Write to Bucket A
• User B can Read from Bucket B
