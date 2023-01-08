pipeline {
    agent any

    stages {
        stage('Init') {
            steps {
              sh """
              #!/bin/bash
              pwd
              ls -lat
              cd packer-build-image
              # packer init config.pkr.hcl
              """
            }
        }
        stage('Test') {
            steps {
              sh """
              #!/bin/bash
              cd packer-build-image
              packer fmt -check .
              """
            }
        }
        stage('Build') {
            steps {
              sh """
              #!/bin/bash
              cd packer-build-image
              packer validate packer-ansible.json
              """
            }
        }
        stage('Publish') {
            steps {
                echo 'Publishing..'
              sh """
              #!/bin/bash
              cd packer-build-image
              packer build packer-ansible.json
              """
            }
        }
        stage('Cleanup') {
            steps {
                echo 'Cleaning..'
                echo 'Running docker rmi..'
            }
        }
    }
}