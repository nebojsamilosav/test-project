terraform {
  backend "s3" {
    bucket = "test-nmil-tf-state"  ### single bucket for all states
    key    = "prod/terraform.tfstate"  ### different folder/path for envs
    region = "eu-central-1"
  }
}