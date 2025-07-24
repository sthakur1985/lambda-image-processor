
variable "bucket_name" { 
type = string 
}
variable "lambda_arn" { 
type = string 
}
variable "lambda_permission" {
type = any 
description = "reference to lambda permission resource to check dependency"
}

