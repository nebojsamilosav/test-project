terraform {
  backend "s3" {
    bucket = "test-nm-tf-state"  ### single bucket for all states
    key    = "dev/terraform.tfstate"  ### different folder/path for envs
    region = "eu-central-1"
  }
}