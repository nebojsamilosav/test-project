module "this" {
  source = "../../"

  ### ENV
  env           = "stage"
  
  instance_type = "t3.micro"
  ami_id        = "ami-0387413ed05eb20af" # Amazon Linux 2023 

### select modules used in this env ###
  ec2       = true
  s3_bucket = true

}

