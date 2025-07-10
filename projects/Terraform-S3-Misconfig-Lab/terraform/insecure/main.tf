provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_user" "bad_user" {
  name = "terraform-crypto-actor"
}

resource "aws_iam_user_policy" "bad_policy" {
  name = "overpowered-policy"
  user = aws_iam_user.bad_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
    }]
  })
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "misconfig-demo-bucket-chad-unique"
  tags = {
    Name = "Public Bucket"
    Env  = "Lab"
  }
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.public_bucket.arn}/*"
      }
    ]
  })
}


resource "aws_s3_object" "test_file" {
  bucket = aws_s3_bucket.public_bucket.id
  key    = "index.html"
  source = "index.html"

  # Remove acl line
}


resource "aws_s3_bucket_public_access_block" "disable_block_public_acls" {
  bucket                  = aws_s3_bucket.public_bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}


resource "aws_security_group" "open_ssh" {
  name        = "open-ssh"
  description = "Open SSH for lab purposes"
  vpc_id      = "vpc-04a380c23d0b8672a"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "open-ssh-group"
  }
}
