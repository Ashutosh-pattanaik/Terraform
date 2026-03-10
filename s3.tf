resource "aws_s3_bucket" "simple_storage_service" {
  bucket = "my-tf-first-bucket-2026"
  
  tags = {
    Name        = "My-tf-bucket2026"
    Environment = "Dev"
  }
}
