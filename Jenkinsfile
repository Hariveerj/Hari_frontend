pipeline {
    agent { label "server" }

    stages {
        stage('git') {
            steps {
                git branch: 'main', credentialsId: 'Credentials', url: 'https://github.com/Hariveerj/Hari_frontend.git'
            }
        }
        stage('Deploy') {
            steps {
                echo "building the docker image..."
                dir('/project1/workspace/pipeline') {
                    sh 'sudo docker-compose up -d'
                }
            }
        }
    }
}
