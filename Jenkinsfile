@Library('devops-libs') _


pipeline {
  agent any 

    parameters {
        string(
            name: 'SCM_URL',
            description: 'The URL (HTTPS or SSH URI) to the source repository',
            defaultValue: 'https://github.com/qodirovshohijahon/devops-tasks'
        )
    }
    stages {
        stage('Soo ---- Initialize Packer Templates and Configs') {
            steps {
                script {
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