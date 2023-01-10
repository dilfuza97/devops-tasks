library('jenkins-devops-libs')
_
// library(
//   identifier: 'jenkins-devops-libs@master',
//   retriever:   modernSCM(
//     [$class:  'GitSCMSource',
//      remote:  'https://github.com/mschuchard/jenkins-devops-libs.git']
//   )
// )
pipeline {
  agent any //{ docker { image 'hashicorp/packer:1.7.10' } }

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
        stage('Initialize Packer Templates and Configs') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    userRemoteConfigs: [[credentialsId: 'qodirovgit', url: params.SCM_URL]],
                    branches: [[name: '*/master']],
                    extensions: [[$class: 'CleanCheckout']],
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
                        template: './packer-ansible.json'
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