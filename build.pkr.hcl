packer {
  required_plugins {
    googlecompute = {
      version = "~> v1.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}


source "googlecompute" "ex" {
  image_name              = "test-packer-example"
  machine_type            = "e2-small"
  source_image            = "debian-10-buster-v20210316"
  ssh_username            = "packer"
  temporary_key_pair_type = "rsa"
  temporary_key_pair_bits = 2048
  zone                    = "us-central1-f"
  project_id              = "packer-and-g-213-ecc33178"
}

build {
  sources = ["source.googlecompute.ex"]
  provisioner "shell" {
    inline = [
      "echo Hello From Github"
    ]
  }
}
