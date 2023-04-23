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

    post {
        always {
            script {
                // Get the date and time
                def dateTime = sh(returnStdout: true, script: 'date').trim()

                // Get the current git branch name and short commit hash
                def branchName = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                def commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()

                // Generate the output
                echo "Date and Time: ${dateTime}"
                echo "Current Git Branch: ${branchName}"
                echo "Current Short Commit Hash: ${commitHash}"
                echo "Automation Output: Build and deploy completed successfully"
            }
        }
        
    }   
       
}
