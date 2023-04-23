pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-jenkins-PAT', url: 'https://github.com/padnin/Resume.git'
            }
        }
        stage('Build') {
            steps {
                sh './deploy.sh'
            }
        }
        
    }   
       
}
