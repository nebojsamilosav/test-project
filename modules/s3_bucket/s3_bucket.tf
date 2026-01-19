resource "aws_s3_bucket" "s3_bucket_test" {
  bucket = "${var.env}-basiq-project-bucket"
}
