
variable "bucket_name" { 
type = string 
}
variable "lambda_arn" { 
type = string 
default = null
}
variable "lambda_permission" {
type = any 
description = "reference to lambda permission resource to check dependency"
}

variable "lambda_name" {
type = string
default = null
}

