resource "aws_instance" "this" {
  
  ami		        = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "${var.env}-test-instance"
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "ec2_policy" {
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
        ]
        Effect = "Allow"
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*",
        ]
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.env}-instance-profile"
  role = aws_iam_role.ec2_role.name
}