pipeline {
    agent { label 'maheshbabu' }
    stages {
        stage('Validate Commit Messages') {
            steps {
                script {
                    def commitMessage = sh(
                        script: "git log -1 --pretty=%B",
                        returnStdout: true
                    ).trim()

                    if (!commitMessage.equals("pawankalyan") && !commitMessage.contains("JIRA-")) {
                        error "ఒరేయ్, పోరం బోకు సరిగ్గా కామెంట్ పెట్టు"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                dir('/maheshbabu/workspace/devops_main/') {
                    sh 'docker-compose up --build -d'
                }
            }
        }
        // Adding curl check without changing the above script
        stage('check the website is visible or not') {
            steps {
                script {
                    def response = sh(
                        script: 'curl -o /dev/null -s -w "%{http_code}" http://16.170.159.34:90/',
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
