@Library('github.com/mschuchard/jenkins-devops-libs@2.0.1')_


pipeline {
  agent { docker { image 'hashicorp/packer:1.7.10' } }

    parameters {
        string(
            name: 'SCM_URL', 
            description: 'The URL (HTTPS or SSH URI) to the source repository \
            containing the Packer templates and configs (should also contain \
            provisioning and validation support code for the artifact).'
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