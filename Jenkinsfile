pipeline {
    agent { label 'server' }

    stages {
        stage('Git') {
            steps {
                git branch: 'main',
                    credentialsId: 'githubtoken',
                    url: 'https://github.com/Hariveerj/Hari_frontend.git'
            }
        }

        stage('Validate Commit Messages') {
            steps {
                script {
                    def commitMessage = sh(
                        script: "git log -1 --pretty=%B",
                        returnStdout: true
                    ).trim()

                    if (!commitMessage.equals("pawankalyan") && !commitMessage.contains("JIRA-")) {
                        error "Orei, poram boku sarei na comment pettu"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                dir('/project1/workspace/pipeline') {
                    sh 'docker-compose up --build -d'
                }
            }
        }
        // Adding curl check without changing the above script
        stage('Check Website Availability') {
            steps {
                script {
                    def response = sh(
                        script: 'curl -o /dev/null -s -w "%{http_code}" http://13.51.161.45:90/',
                        returnStdout: true
                    ).trim()

                    if (response != '200') {
                        error "Website is not accessible, HTTP status code: ${response}"
                    } else {
                        echo "Website is accessible with status code: ${response}"
                    }
                }
            }
        }
        stage('Merge to Test') {
            when {
                expression {
                    def response = sh(
                        script: 'curl http://13.51.161.45:90/',
                        returnStdout: true
                    ).trim()
                    return response // Merge only if the response is valid
                }
            }
            steps {
                script {
                    // Clone the repository to work with it
                    git branch: 'test',
                        credentialsId: 'Credentials',
                        url: 'https://github.com/Hariveerj/Hari_frontend.git'
                    sh 'git checkout test'
                    sh 'git merge origin/main'
                    sh 'git push origin test'
                    echo "code merged sucessfully"
                }
            }
        }
    }
}
