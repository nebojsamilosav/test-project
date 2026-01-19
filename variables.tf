variable "env" {
  type        = string
  description = "environment name for deployment"
}

variable "instance_type" { type = string }
variable "ami_id" { type = string }


########################################
# variables for resources in use per env
########################################

variable "ec2" {
  type    = bool
  default = false
}


variable "s3_bucket" {
  type    = bool
  default = false
}