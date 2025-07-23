terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "s3-exif-stripper/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    use_lockfile = true
  }
}
