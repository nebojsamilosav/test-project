module "ec2" {
  source = "./modules/ec2"
  count  = var.ec2 == true ? 1 : 0

  env                   = var.env
  
  instance_type = var.instance_type
  ami_id        = var.ami_id
  s3_bucket_arn = module.s3_bucket[0].s3_bucket_arn
}

module "s3_bucket" {
  source = "./modules/s3_bucket"
  count  = var.s3_bucket == true ? 1 : 0

  env                   = var.env
  
}
