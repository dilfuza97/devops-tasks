packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.0.0"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

"builders" = {
  "account_file" = "account.json"

  "disk_size" = 30

  "image_description" = "spring boot application image"

  "image_labels" = {
    "role" = "web"

    "team" = "devops"
  }

  "image_name" = "springbootapp"

  "project_id" = "packer-and-g-213-ecc33178"

  "source_image_family" = "centos-7"

  "ssh_username" = "ansible"

  "type" = "googlecompute"

  "zone" = "us-central1-f"
}

"provisioners" = {
  "inline" = ["sudo yum install -y python3 \u0026\u0026 sudo yum -y install ansible \u0026\u0026 sleep 3 \u0026\u0026 ansible --version"]

  "type" = "shell"
}

"provisioners" = {
  "command" = "ansible-playbook"

  "playbook_file" = "playbook.yml"

  "type" = "ansible-local"
}