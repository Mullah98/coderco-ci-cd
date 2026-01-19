terraform {
  required_version = ">= 1.7.0"
}

resource "null_resource" "example"{
  # intentionally misformatted: no space before {
  triggers = {
    always_run = timestamp()
  }
}
