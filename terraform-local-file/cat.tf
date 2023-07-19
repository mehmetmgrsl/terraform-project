resource "local_file" "cat" {
  filename = "/root/cats.txt"
  content = "We love cats too!"
  file_permission = "0700"
}