// library(
//   identifier: 'jenkins-devops-libs@master',
//   retriever:   modernSCM(
//     [$class:  'GitSCMSource',
//      remote:  'https://github.com/mschuchard/jenkins-devops-libs.git']
//   )
// )
pipeline {
  agent { docker { image 'hashicorp/packer' } }

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
//            agent {
//                docker { image 'hashicorp/packer' }
//            }
            steps {
                checkout([
                    $class: 'GitSCM',
                    userRemoteConfigs: [[ url: params.SCM_URL]],
                    branches: [[name: '*/master']],
                    extensions: [[$class: 'CleanCheckout']],
                ])
                sh 'packer init .'
            }
        }
        stage('Packer Templates and Configs Validation') {
//            agent {
//                docker { image 'hashicorp/packer' }
//            }            
            steps {
                sh 'packer fmt .'
            }
        }
        
        stage('Build Image Artifacts') {
//            agent {
//                docker { image 'hashicorp/packer' }
//            }            
            steps {
                sh 'packer build'
            }
        }
    }
}