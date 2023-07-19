resource "local_file" "pet_new" {
    filename = var.filename[count.index]
    content = "We love new pets too!"

    count = length(var.filename)
  
}
