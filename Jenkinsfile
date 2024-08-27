pipeline {
	agent {
		label $(env.BRANCH_NAME == 'prod' ? 'maheshbabu' : env.BRANCH_NAME == 'stage' ? 'powerstar')
	}
	stages {
		stage('Deploy') {
			
			steps {
				def commitMessage = sh(
					script: "git log -1 --pretty=%B",
					returnStdout: true
				).trim()
				steps {
					dir(env.BRANCH_NAME == 'prod' ? '/maheshbabu/workspace/devops_main' : '/powerstar/workspace/devops_main') {
						sh 'docker-compose up --build -d'
					}
				}	
			}
		}
		stage('Check Website Availability') {
			steps {
				def url = ''
				
				if (env.BRANCH_NAME == 'prod') {
					url = 'http://13.50.5.108:90/'
				} else if (env.BRANCH_NAME == 'stage') {
					url = 'http://16.170.159.34:90/'
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
