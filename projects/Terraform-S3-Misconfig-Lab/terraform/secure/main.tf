provider "aws" {
  region = "us-east-2"
}

###################
# This was used to create the malicious overprovisioned user.
# Keeping this active and not commented out would cause major risk
###################
# resource "aws_iam_user" "bad_user" {
#   name = "terraform-crypto-actor"
# }

# resource "aws_iam_user_policy" "bad_policy" {
#   name = "overpowered-policy"
#   user = aws_iam_user.bad_user.name

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect   = "Allow"
#       Action   = "*"
#       Resource = "*"
#     }]
#   })
# }

##################
# I am KEEPING the S3 bucket (for normal app infrastructure use)
# Though I am REMOVING the public-read policy
# I will re-enable the block public access setting
#################

resource "aws_s3_bucket" "public_bucket" {
  bucket = "misconfig-demo-bucket-chad-unique"
  tags = {
    Name = "Public Bucket"
    Env  = "Lab"
  }
}

# resource "aws_s3_bucket_policy" "public_read_policy" {
#  bucket = aws_s3_bucket.public_bucket.id

#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Sid    = "PublicReadGetObject"
#        Effect = "Allow"
#        Principal = "*"
#        Action   = "s3:GetObject"
#        Resource = "${aws_s3_bucket.public_bucket.arn}/*"
#      }
#    ]
#  })
#}

# I am keeping the upload of this file (but this time it will be PRIVATE) 
resource "aws_s3_object" "test_file" {
  bucket = aws_s3_bucket.public_bucket.id
  key    = "index.html"
  source = "index.html"

}

# I will be keeping this section, but ENFORCING the block public access settings
resource "aws_s3_bucket_public_access_block" "disable_block_public_acls" {
  bucket                  = aws_s3_bucket.public_bucket.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

#################
# I am keeping this security group, but limiting the access
# Instead of "All" or 0.0.0.0/0 I will limit it to my own IP address
#################

resource "aws_security_group" "open_ssh" {
  name        = "restricted-ssh"
  description = "Restricted SSH for lab purposes"
  vpc_id      = "vpc-04a380c23d0b8672a"

  ingress {
    description = "SSH from known IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["71.195.235.59/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "restricted-ssh-group"
  }
}
