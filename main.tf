module "bucket_a" {
  source         = "./modules/s3_bucket"
  bucket_name    = "source-bucket-a"
  lambda_arn     = module.lambda.lambda_arn
  lambda_permission = module.lambda.lambda_permission
}

module "bucket_b" {
  source      = "./modules/s3_bucket"
  bucket_name = "destination-bucket-b"
  lambda_arn  = "" # no lambda triggers
  lambda_permission = null
}

module "iam" {
  source        = "./modules/iam_roles"
  name          = "exif-stripper-lambda-role"
  bucket_a_arn  = module.bucket_a.bucket_id
  bucket_b_arn  = module.bucket_b.bucket_id
}

module "lambda" {
  source            = "./modules/lambda_function"
  function_name     = "exif-stripper"
  role_arn          = module.iam.role_arn
  source_bucket_arn = module.bucket_a.bucket_id
}

#module "iam_users" {
 # source         = "./modules/iam_users"
 # bucket_a_name  = module.bucket_a.bucket_name
 # bucket_b_name  = module.bucket_b.bucket_name
#}

