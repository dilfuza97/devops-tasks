@Library('devops-libs') _


pipeline {
  agent any 
//   agent { docker { image 'hashicorp/packer:1.7.10' } }


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
                    dir:     '.',
                    upgrade: true
                )
                }
            }
        }
        stage('Plugins') {
            steps {
                script {
                packer.plugins(command: 'installed')
                packer.plugins(
                    command: 'installed',
                    dir:     '.'
                )
                }
            }
        }
        stage('Validate') {
            steps {
                script {
                packer.validate(template: 'template.pkr.json')
                packer.validate(template: 'config.pkr.hcl')
                }
            }
        }
        
        stage('Packer Templates and Configs Validation') {
            steps {
                script {
                // remember template param also targets directories
                    packer.validate(template: '.')
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
                packer.build(template: '.')
                }
            }
        }
    }
}