pipeline {
    agent any
    stages {
        stage('SCM Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/khushalt-icpl/React-Admin.git'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeServer') {
                  bat "C:/sonar-scanner-4.7.0.2747-windows/bin/sonar-scanner -D sonar.login=admin -D sonar.password=Khushal@123 -D sonar.projectKey=example2 -D sonar.exclusions=vendor/**,resources/**,**/*.java -D sonar.host.url=http://localhost:9000"
                }
            }
        }
        stage('unit test'){
            steps{
                bat "npm install"
                bat "npm run test"
            }
        }
        stage('Build'){
            steps{
                bat "npm run build"
            }
        }
      
        stage('Quality Gate') {
            steps {
                script{
                timeout(time: 1, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
                if(currentBuild.result == 'FAILUER') {
                    echo 'Quality gate has failuer'
                } 
                else{
                    echo 'Quality gate has success'
                    currentBuild.result = 'SUCCESS'
                }
            }
        }
        }
        stage('Deployment'){
            agent any
            steps{
                bat "docker build -t khushal123/react ."
            }
        }
        stage('Docker Push') {
    	    agent any
            steps {
      	        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        	    bat "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                bat 'docker push khushal123/react'
            }
      }
    }
    }
    post {
        always {
            echo 'Job completed'
        }
    }
}
