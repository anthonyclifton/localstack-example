resource "aws_s3_bucket" "testbucket" {
  bucket = "testbucket"
  acl    = "private"

  tags = {
    Name        = "Test bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "test_file" {
  bucket = "${aws_s3_bucket.testbucket.bucket}"
  key    = "testfile"
  source = "../frontend/index.html"
}