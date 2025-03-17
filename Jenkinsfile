pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        DOCKERHUB_USER = '<your-dockerhub-username>'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/myrepo/mern-app.git'
            }
        }
        stage('Check if Infra Exists') {
            steps {
                script {
                    def eksCluster = sh(script: "aws eks describe-cluster --name mern-cluster --region us-east-1 --query 'cluster.status' --output text || echo 'NOT_FOUND'", returnStdout: true).trim()
                    
                    if (eksCluster == "ACTIVE") {
                        echo "✅ Infrastructure exists. Skipping Terraform apply."
                    } else {
                        echo "🚀 Infrastructure not found. Running Terraform apply."
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Build & Push Docker Images') {
            steps {
                sh 'docker build -t $DOCKERHUB_USER/mern-backend:v1 ./backend'
                sh 'docker build -t $DOCKERHUB_USER/mern-frontend:v1 ./frontend'
                sh 'docker push $DOCKERHUB_USER/mern-backend:v1'
                sh 'docker push $DOCKERHUB_USER/mern-frontend:v1'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/backend-deployment.yaml'
                sh 'kubectl apply -f k8s/frontend-deployment.yaml'
            }
        }
    }
}

