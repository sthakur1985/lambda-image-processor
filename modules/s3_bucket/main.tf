
# modules/s3_bucket/main.tf
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_notification" "bucket_notify" {
  bucket_arn = aws_s3_bucket.bucket.arn

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".jpg"
  }

  depends_on = [var.lambda_permission]
}

