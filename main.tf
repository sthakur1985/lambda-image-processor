module "bucket_a" {
  source         = "./modules/s3_bucket"
  bucket_name    = var.bucket_name[0]
  lambda_arn     = module.lambda.lambda_arn
  lambda_permission = module.lambda.lambda_permission
  lambda_name = module.lambda.lambda_name
}

module "bucket_b" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name[1]
  #lambda_arn  = "" # no lambda triggers
  lambda_permission = ""
}

module "lambda" {
  source            = "./modules/lambda_function"
  function_name     = var.lambda_name
  role_arn          = module.iam.role_arn
  source_bucket_arn = module.bucket_a.bucket_arn
  source_bucket_name = module.bucket_a.bucket_id
}

module "iam" {
  source        = "./modules/iam_roles"
  name          = var.lambda_role
  bucket_a_arn  = module.bucket_a.bucket_arn
  bucket_b_arn  = module.bucket_b.bucket_arn
}


module "iam_users" {
  source         = "./modules/iam_users"
  bucket_a_name  = module.bucket_a.bucket_id
  bucket_b_name  = module.bucket_b.bucket_id
}

