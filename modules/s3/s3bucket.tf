resource "aws_s3_bucket" "bambuk" {
  bucket = "bambuk"
 #acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Demo"
  }
}