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
        stage('Initialize Packer Templates and Configs') {
        steps {
            checkout([
            $class:            'GitSCM',
            userRemoteConfigs: [[url: params.SCM_URL]]
            ])
            script {
            packer.init(
                dir:     './packer-build-image',
                upgrade: true
            )
            }
        }
        }
        stage('Packer Templates and Configs Validation') {
        steps {
            script {
            // remember template param also targets directories
            packer.validate(template: './packer-build-image')
            packer.fmt(
                check:    true,
                diff:     true,
                template: '.'
            )
            }
        }
        }
        stage('Build Image Artifacts') {
        steps {
            script {
            packer.build(template: './packer-build-image')
            }
        }
        }
    }
}