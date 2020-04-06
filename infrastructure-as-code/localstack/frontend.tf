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

  tags = {
    Name        = "Test bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "website_index" {
  bucket = "${aws_s3_bucket.testbucket.bucket}"
  acl = "public-read"
  key    = "index.html"
  source = "../../frontend/index.html"
}
