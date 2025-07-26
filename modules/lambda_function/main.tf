# lambda fuction to process the uploaded image in source bucket using python code

resource "aws_lambda_layer_version" "pillow_layer" {
  filename         = "${path.module}/src/pillow-layer.zip"
  layer_name       = "custom-pillow"
  compatible_runtimes = ["python3.9"]
}

resource "aws_lambda_function" "lambda_py" {

  filename         = "${path.module}/src/lambda.zip"
  function_name    = var.function_name
  role             = var.role_arn
  handler          = "handler.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("${path.module}/src/lambda.zip")
  timeout          = 10
  layers = [aws_lambda_layer_version.pillow_layer.arn]
  environment {
    variables = {
      DEST_BUCKET = var.destination_bucket_name
    }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke--${var.source_bucket_name}"
  #statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_py.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.source_bucket_arn
}



