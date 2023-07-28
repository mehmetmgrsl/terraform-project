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


resource "aws_instance" "webserver" {
  ami           = "ami-08766f81ab52792ce"
  instance_type = "t3.micro"

  tags = {
    Name = "webserver"
    Description = "An nginx webserver on Ubuntu 20.04"
  }   

  key_name = aws_key_pair.web-nginx.key_name
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "web-nginx" {
  key_name   = "web-nginx"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDfULsnOgV0RaL+8CEmV7xjgnkfpWTsMP5qIRXffKJFBL4AN0Wf9FekPNWUvpEKlOs7wsI1VcZ4x1KgjKQY44ansMftGKv3Yr7jhmJM8F+Gi7jzXHS8F5RlYw3qbZ+W47hbWBRB9qcHMoXRWiL4Num8DiGr5VS9U9/fSLEkNeLKOy1JUZmK83NrNuH/JcxwwmB33lUOEz5YN3TCzp1I0ZptE1QzCn5u+YO9AhxK1mfRNjZndHO3x+AZJDfTiBzwRiTyE0zlWJEclKqqC+yBpP2KSndYw3wv+2M06FQVHfwU1s5L/eMNZ3N+pIOiVYZkwFNzmS0h7InShYT/paLiwTp0Q9nNw4xfs6LjV2ThaFOAlaCE8d9MIorLV0OxJw666ilitJ6jb1xuxUG+3L0xobG6Ycw7nKS/lPhDaXs7OV/m8hfPUFV9lW5OhXDA0+gzwsCwbb9aMATeJZgzQFtJJDr55mqnBxTGwyKxn6rnkjHT9l59uMwbSBPoHU3hoW3NKYVGMBRMcjT3Bm+MRNB13KoJzFoAuDLs5lNcf7vUnSliwhEWMCsCJkezMXkAYWMt0aDTkJmU8Nd72U5/GDsPx6RBbP2lkRHjl4J1kOiQcPght367vBTPL6X4rcMhdxPNl6nVvTlFJ3OWheoHYBwvY+7Fro75QQUyver5L+EWx9pN7w== mguersul@mehmet"
}

resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "Allow SSH access from the Internet"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

output publicip {
  value = aws_instance.webserver.public_ip
}





