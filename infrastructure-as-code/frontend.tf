resource "aws_s3_bucket" "testbucket" {
  bucket = "testbucket"
  acl = "public-read"
  policy = <<EOF
  {
    "Version":"2008-10-17",
    "Statement":[{
      "Sid":"AllowPublicRead",
      "Effect":"Allow",
      "Principal": {"AWS": "*"},
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::testbucket/*"]
    }]
}
EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  tags = {
    Name        = "Test bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "website_index" {
  bucket = "${aws_s3_bucket.testbucket.bucket}"
  acl = "public-read"
  key    = "index.html"
  source = "../frontend/index.html"
}

output "website_endpoint" {
  value = "${aws_s3_bucket.testbucket.website_endpoint}"
}
