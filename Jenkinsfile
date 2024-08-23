pipeline {
    agent any
    stages {
        stage('Build Docker') {
            steps {
                sh 'echo "FROM alpine" > Dockerfile'
                sh 'docker build -t test-alpine .'
            }
        }
    }
}
