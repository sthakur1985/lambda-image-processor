# s3 bucket to store tf state with state locking enabled

terraform {
  backend "s3" {
    bucket         = "terraform-st-bucket-0725"
    key            = "s3-exif-stripper/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    use_lockfile   = false
  }
}
