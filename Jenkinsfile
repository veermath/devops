pipeline {

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  none
    stages {
        stage('Terraform Init') {
            agent {label 'agent'}
           steps {
                script {
                        sh 'terraform init'
                }
           }
        }
        stage('Terraform validate') {
            agent {label 'agent'}
           steps {
                script {
                        sh 'terraform validate'
                }
           }
        }
        stage('Terraform Plan') {
            agent {label 'agent'}
           steps {
                script {
                    sh 'terraform plan =out=tfplan'
                }
           }
        }
        stage('Terraform Apply') {
            agent {label 'agent'}
           steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'
                }
           }
        }
    }
}
  
