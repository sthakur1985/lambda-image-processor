# lambda-image-processor tasks

Task1: A company allows their users to upload pictures to an S3 bucket. These pictures are always in the .jpg format.
The company wants these files to be stripped from any exif metadata before being shown on their website.
Pictures are uploaded to an S3 bucket A.
Create a system that retrieves .jpg files when they are uploaded to the S3 bucket A, removes any exif metadata,
and save them to another S3 bucket B. The path of the files should be the same in buckets A and B.
Task2: To extend this further, we have two users User A and User B. Create IAM users with the following access:
• User A can Read/Write to Bucket A
• User B can Read from Bucket B

# Actions

To implement the system we shall use AWS lambda, IAM role, s3 bucket and python modules. Terraform modular structure will be used to 
implement reusable solution. 
s3 bucket: bucket-a( source ), bucket-b( destination ), tf-state-bucket( to hold terraform state)
iam roles: Allows Lambda access  bucket-a (get, list) and bucket-b(put, list). Also roles for user-a to (get/list/put/delete) and user-b to (get, list)
lambda function: to process images in .jpg with EXIF metadata, striping using python modules from bucket-a and store clean image in bucket-b.


