
variable "bucket_name" { 
  type = list(string) 
  default = ["source-bucket-a-0725", "destination-bucket-b-0725"]
}

variable "lambda_name" { 
type = string 
default = "exif-stripper"
}

variable "lambda_role" { 
type = string 
default = "exif-stripper-lambda-role-0725"
}
