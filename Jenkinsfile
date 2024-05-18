pipeline {

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
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
                    sh 'terraform plan'
                }
           }
        }
        stage('Terraform Apply') {
           steps {
                script {
                    sh 'terraform apply -auto-approve'
                }
           }
        }
        stage('Terraform destroy') {
           steps {
                script {
                    sh 'terraform destroy -auto-approve'
                }
           }
        }
    }
}
  
