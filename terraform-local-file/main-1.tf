terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.3.0"
    }
  }
}

resource "local_file" "pet_new" {
    filename = var.filename[count.index]
    content = "We love new pets too!"

    count = length(var.filename)
  
}
