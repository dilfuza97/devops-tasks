library(
  identifier: 'jenkins-devops-libs@master',
  retriever:   modernSCM(
    [$class:  'GitSCMSource',
     remote:  'https://github.com/qodirovshohijahon/jenkins-devops-libs.git']
  )
)
pipeline {
  agent any // { docker { image 'hashicorp/packer:1.7.10' } }

    parameters {
        string(
            name: 'SCM_URL',
            description: 'The URL (HTTPS or SSH URI) to the source repository \
            containing the Packer templates and configs (should also contain \
            provisioning and validation support code for the artifact).',
            defaultValue: 'https://github.com/qodirovshohijahon/devops-tasks'
        )
    }
    stages {
        stage('Soo ---- Initialize Packer Templates and Configs') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    userRemoteConfigs: [[ url: params.SCM_URL]],
                    branches: [[name: '*/master']],
                    extensions: [[$class: 'CleanCheckout']],
                ])
                script {
                    // remember template param also targets directories
                    packer.fmt(
                        check:    false,
                        diff:     false,
                        template: './packer-build-image'
                    )
                }
            }
        }
        stage('Build Image Artifacts') {
            steps {
                script {
                    packer.build(
                        template: 'packer-build-image'
                    )
                }
            }
        }
    }
}