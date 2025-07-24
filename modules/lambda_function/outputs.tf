output "lambda_arn" {
  value = aws_lambda_function.lambda_py.arn
}

output "lambda_permission" {
  value = aws_lambda_permission.allow_s3
}

output "lambda_name" {
  value = aws_lambda_function.lambda_py.function_name
}
