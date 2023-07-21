resource "aws_dynamodb_table" "cars" {
  name         = "cars"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "VIN"

  attribute {
    name = "VIN"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "dev"
  }
}

resource "aws_dynamodb_table_item" "car-tems" {
  table_name = aws_dynamodb_table.cars.name
  hash_key   = aws_dynamodb_table.cars.hash_key

  item = <<ITEM
   {
     "VIN": {"S": "4YEFEEGRGRETRTRE"},
     "make": {"S": "Corolla"},
     "year": {"N": "2011"},
     "Manufacturer": {"S": "Toyota"}
   }
ITEM
}


resource "aws_s3_bucket" "wheather" {
  bucket = "wheather-2023-07-19"

  tags = {
    Description = "Wheather"
  }
}

resource "aws_s3_object" "wheather-2023-19-07" {
  bucket = aws_s3_bucket.wheather.id
  key    = "test-file.txt"
  source = "./test-file.txt"
}


resource "aws_s3_bucket_policy" "wheather-policy" {
  bucket = aws_s3_bucket.wheather.id
  policy = data.aws_iam_policy_document.wheather-policy-data.json

}

data "aws_iam_policy_document" "wheather-policy-data" {
  statement {

    principals {
      type        = "AWS"
      identifiers = ["480086499241"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.wheather.arn,
      "${aws_s3_bucket.wheather.arn}/*",
    ]

  }
}





