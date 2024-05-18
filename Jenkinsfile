pipeline {

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                            git branch: 'terraform', url: 'https://github.com/veermath/devops.git'
                    }
                }
            }
        stage('Terraform Init') {
           steps {
                scripts {
                    dir("terraform") {
                        sh 'terraform init'
                    }
                }
           }
        }
        stage('Terraform Plan') {
           steps {
                scripts {
                    sh 'terraform plan =out=tfplan'
                }
           }
        }
        stage('Terraform Apply') {
           steps {
                scripts {
                    sh 'terraform apply -auto-approve tfplan'
                }
           }
        }
    }
}
  
