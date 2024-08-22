pipeline {
    agent { label "project_node1"}
    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main',
                    credentialsId: 'Git_Credentials',
                    url: 'https://github.com/Hariveerj/serverlepestha.git'
            }
        }
        stage('build the docker image') {
            steps {
                script {
                    echo "building the docker image..."
                    sh 'docker-compose build'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "starting container..."
                    sh 'docker-compose up -d'
                }
            }
        }
    }
}