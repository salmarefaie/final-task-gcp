
pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                 git url:'https://github.com/salmarefaie/final-task-gcp.git',
                 branch:'main',
                 credentialsId:'salmarefaie'
            }
        }
        stage('cd Terraform'){
              steps {
                sh 'cd Terraform'
            }
        }
        
        stage('terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('terraform Apply') {
            steps {
                sh """
                
                terraform apply -auto-approve -no-color
                terraform apply -auto-approve -no-color

                
            
                """
            }
        }
    }
} 
