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
        post {
                always {
                    script {
                        // Get current Git branch name and commit hash
                        def gitBranch = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                        def gitCommitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                        
                        
                        // Validate site
                        echo "Site validation result:"
                        try {
                            sh 'run-site-validation.sh'
                        } catch (err) {
                            error "Site validation failed: ${err}"
                        }
                    }
                }
            }
        }
    }   
       
}
