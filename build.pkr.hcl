# builders = {
#   "type" = "googlecompute"

#   "project_id" = "packer-and-g-213-ecc33178"

#   "account_file" = "account.json"

#   "source_image_family" = "centos-7"

#   "zone" = "us-central1-f"

#   "ssh_username" = "ansible"

#   "image_name" = "springbootapp"

#   "disk_size" = 30

#   "image_description" = "spring boot application image"

#   "image_labels" = {
#     "role" = "web"

#     "team" = "devops"
#   }
# }



# provisioners = {
#   "type" = "shell"

#   "inline" = ["sudo yum install -y python3 && sudo yum -y install ansible && sleep 3 && ansible --version"]
# }

# provisioners = {
#   "type" = "ansible-local"

#   "command" = "ansible-playbook"

#   "playbook_file" = "playbook.yml"
# }


#source "googlecompute" "ex" {
 # type = "googlecompute"
 # project_id = "packer-and-g-213-ecc33178"
  #account_file = "account.json"
 # source_image_family = "centos-7"
  #zone = "us-central1-f"
 # ssh_username = "ansible"
  #image_name = "springbootapp"
  #disk_size = 30
 # image_description = "spring boot application image"
#}

#build {
 # sources = ["source.googlecompute.ex"]
 # provisioner "shell" {
  #  inline = [
    #  "sudo yum install -y python3 && sudo yum -y install ansible && sleep 3 && ansible --version"
  #  ]
 # }
#}

#
{
    builders: [
      {
        "type": "googlecompute",
        "project_id": "packer-and-g-213-ecc33178",
        "account_file": "account.json",
        "source_image_family": "centos-7",
        "zone": "us-central1-f",
        "ssh_username": "ansible",
        "image_name": "springbootapp",
        "disk_size": 30,
        "image_description": "spring boot application image",
        "image_labels": {
            "role": "web",
            "team": "devops"
        }
    }
],
"provisioners": [
    {
        "type": "shell",
        "inline": [
            "sudo yum install -y python3 && sudo yum -y install ansible && sleep 3 && ansible --version"
        ]
    },
    {
        "type": "ansible-local",
        "command": "ansible-playbook",
        "playbook_file": "playbook.yml"
    }
]
}
