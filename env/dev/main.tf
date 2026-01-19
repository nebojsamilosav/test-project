module "this" {
  source = "../../"

  ### ENV
  env           = "dev"
  
  instance_type = "t3.micro"
  ami_id        = "ami-0387413ed05eb20af" # Amazon Linux 2023 

    ### select modules used in this env ###
  ec2       = true
  s3_bucket = true

}

# module "ec2" {
#   source   = "../../modules/ec2"
#   env_name = "dev"
# }