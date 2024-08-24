pipeline {
    agent { label "server" }

    stages {
        stage('git') {
            steps {
                git branch: 'main', credentialsId: 'Credentials', url: 'https://github.com/Hariveerj/Hari_frontend.git'
            }
        }
        stage('Validate Commit Messages') {
            steps {
                script {
                    def commitMessages = sh(
                        script: "git log -1 --pretty=%B",
                        returnStdout: true
                    ).trim()

                    // Allow specific commit message "repu ra"
                    if (commitMessages != "pawankalyan" && !commitMessages.matches(".*(JIRA-[0-9]+).*")) {
                        error "Orei, poram boku sarei na comment pettu"
                    }
                }
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
