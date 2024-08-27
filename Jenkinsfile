pipeline {
	agent {
		label "$(env.BRANCH_NAME == 'prod' ? 'slave-1' : env.BRANCH_NAME == 'stage' ? 'slave-2')"
	}
	stages {
		stage('Deploy') {
			
			steps {
				def commitMessage = sh(
					script: "git log -1 --pretty=%B",
					returnStdout: true
				).trim()
				
				steps {
					dir('/project1/workspace/pipeline') {
						sh 'docker-compose up --build -d'
					}
				}	
			}
		}
		stage('Check Website Availability') {
			steps {
				def url = ''
				
				if (env.BRANCH_NAME == 'prod') {
					url = ''
				} else if (env.BRANCH_NAME == 'stage') {
					url = ''
				}
				
				def response = sh(
					script: "curl -o /dev/null -s -w \"%{http_code}"${url}",
					returnStdout: true
				).trim()
				
				if (reponse != '200') {
					error "ఎపుడు పోదు పోదుకోవడం తప్పు కాని ఉపయోగం లేదు నీవల్ల లేచి పని చేయి రా రేయ్ ${env.BRANCH_NAME}. HTTP status code: ${response}"
				} else {
					echo "ఎం చేష్టవ్ లేయ్ పోదుకో"
				}
			}
		}
	}
}
