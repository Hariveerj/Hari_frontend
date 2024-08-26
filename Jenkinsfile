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
                        error "ఒరేయ్, పోరం బోకు సారీ అయిన కామెంట్"
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
                        error "నీ పొల్లంలో మొల్లకల్లు రాలేదు పో, HTTP status code: ${response}"
                    } else {
                        echo "నీ పొల్లంలో మొల్లకాలు వచ్చేయ్ రోయీ code: ${response}"
                    }
                }
            }
        }
    }
}
