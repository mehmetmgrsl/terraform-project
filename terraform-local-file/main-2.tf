resource "local_file" "new_pet" {
    filename = each.value
    content = "We love new pets too!"

    for_each = toset(var.filename-2)
  
}