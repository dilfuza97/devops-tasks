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
  source_image            = "centos-7"
  ssh_username            = "ansible"
  temporary_key_pair_type = "packer"
  temporary_key_pair_bits = 2048
  zone                    = "us-central1-f"
  project_id              = "packer-and-g-213-ecc33178"
  account_file            = "account.json" 
  
}

build {
  sources = ["source.googlecompute.ex"]
  provisioner "shell" {
    inline = [
      "sudo yum install -y python3 && sudo yum -y install ansible && sleep 3 && ansible --version"
    ]
  }
}

