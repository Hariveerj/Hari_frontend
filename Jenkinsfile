pipeline {
    agent any
    stages {
        stage('Clone Code') {
            steps {
                script {
                    echo "Cloning repository..."
                    git branch: 'main', credentialsId: 'Git_Credentials', url: 'https://github.com/Hariveerj/Hari_frontend.git'
                }
            }
        }
        stage('Build the Docker Image') {
            steps {
                script {
                    try {
                        echo "Building the Docker image..."
                        sh 'docker-compose build'
                    } catch (Exception e) {
                        echo "Failed to build the Docker image"
                        error "Build stage failed."
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    try {
                        echo "Starting Docker containers..."
                        sh 'docker-compose up -d'
                    } catch (Exception e) {
                        echo "Failed to start Docker containers"
                        error "Deploy stage failed."
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                try {
                    echo "Cleaning up Docker containers..."
                    sh 'docker-compose down || true'
                } catch (Exception e) {
                    echo "Cleanup failed, but the pipeline will proceed."
                }
            }
        }
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
