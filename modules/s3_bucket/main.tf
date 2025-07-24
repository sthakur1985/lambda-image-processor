resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_lambda_permission" "allow_s3" {
  count = var.lambda_name  != null ? 1 : 0
  statement_id = "AllowS3Invoke"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notify" {
  count = var.lambda_name != null ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".jpg"
  }

  depends_on = [
aws_lambda_permission.allow_s3
]
}

