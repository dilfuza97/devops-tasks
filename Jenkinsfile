library(
  identifier: 'jenkins-devops-libs@master',
  retriever:   modernSCM(
    [$class:  'GitSCMSource',
     remote:  'https://github.com/mschuchard/jenkins-devops-libs.git']
  )
)

pipeline {
  agent any 
//   agent { 
//     docker { image 'hashicorp/packer' }
//   }
    parameters {
        string(
            name: 'SCM_URL',
            description: 'The URL (HTTPS or SSH URI) to the source repository',
            defaultValue: 'https://github.com/dilfuza97/devops-tasks'
        )
    }
  
  
    stages {
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
        stage('Initialize Packer Templates and Configs') {
            steps {
                checkout([
                $class:            'GitSCM',
                userRemoteConfigs: [[url: params.SCM_URL]]
                ])
                script {
                packer.init(
                    dir:     './config',
                    upgrade: true
                )
                }
            }
        }
      
//         stage('Validate') {
//             steps {
//                 script {
//                 packer.validate(template: '.')
//                 // packer.validate(template: 'config.pkr.hcl')
//                 }
//             }
//         }
      
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

        stage('generate provenance') {
            steps {
                dir("../workspace") {
                    sh 'rm -rf slsa-jenkins-generator && mkdir slsa-jenkins-generator'

                    dir("slsa-jenkins-generator") {
                        git branch: "main", credentialsId: "$CREDENTIAL_ID", url: "$Repository_Generator"
                        sh "docker build . -t scia:slsa-generator"
                        sh "printenv > ./envlist && docker run --env-file ./envlist -v \"${artifact_path}\":\"/artifacts\" scia:slsa-generator -a artifacts/${artifact_name} -o artifacts"
                    }
                }
            }
        }

    }
}
