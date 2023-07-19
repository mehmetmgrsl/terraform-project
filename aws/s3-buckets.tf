resource "aws_s3_bucket" "wheather" {
    bucket = "wheather-2023-07-19"

    tags = {
        Description = "Wheather"
    }
}

resource "aws_s3_object" "wheather-data" {
  bucket = aws_s3_bucket.wheather.id
  key    = "test-file.txt"
  source = "./test-file.txt"
}