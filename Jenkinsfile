pipeline {

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                    echo 'clone the repo'
                    git branch: 'terraform', changelog: false, poll: false, url: 'https://github.com/veermath/devops.git'
                }
            }
        stage('Terraform Init') {
           steps {
                script {
                        sh 'terraform init'
                }
           }
        }
        stage('Terraform validate') {
           steps {
                script {
                        sh 'terraform validate'
                }
           }
        }
        stage('Terraform Plan') {
           steps {
                script {
                    sh 'terraform plan =out=tfplan'
                }
           }
        }
        stage('Terraform Apply') {
           steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'
                }
           }
        }
    }
}
  
