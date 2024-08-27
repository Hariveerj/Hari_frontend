pipeline {
    agent none
    stages {
        stage('Deploy') {
            agent {
                label "${env.BRANCH_NAME == 'prod' ? 'slave-2' : env.BRANCH_NAME == 'stage' ? 'slave-3' : null}"
            }
            steps {
                script {
                    def commitMessage = sh(
                        script: "git log -1 --pretty=%B",
                        returnStdout: true
                    ).trim()

                    dir('/project1/workspace/pipeline') {
                        sh 'docker-compose up --build -d'
                    }
                }
            }
        }
        stage('Check Website Availability') {
            agent {
                label "${env.BRANCH_NAME == 'prod' ? 'slave-2' : env.BRANCH_NAME == 'stage' ? 'slave-3' : null}"
            }
            steps {
                script {
                    def url = ''

                    // Set the URL based on the branch
                    if (env.BRANCH_NAME == 'prod') {
                        url = 'http://51.20.89.36'
                    } else if (env.BRANCH_NAME == 'stage') {
                        url = 'http://13.53.190.160'
                    }

                    def response = sh(
                        script: "curl -o /dev/null -s -w \"%{http_code}\" ${url}",
                        returnStdout: true
                    ).trim()

                    // Validate the HTTP response code
                    if (response != '200') {
                        error "ఎపుడు పోదు పోదుకోవడం తప్పు కాని ఉపయోగం లేదు నీవల్ల లేచి పని చేయి రా రేయ్ ${env.BRANCH_NAME}. HTTP status code: ${response}"
                    } else {
                        echo "ఎం చేష్టవ్ లేయ్ పోదుకో"
                    }
                }
            }
        }
    }
}
