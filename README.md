# README

This repository contains code for automating the deployment of a web application using a Jenkins pipeline and Docker. The application is a simple static website hosting containing the information about the Resume.

The pipeline performs the following steps:

- Checkout: Checkout the code from the repository
- Build: Build a Docker image using the code
- Deploy: Deploy the Docker image to a container
- Validation: Validate that the website is accessible

# Pipeline

The Jenkins pipeline is defined in the Jenkinsfile and has two stages:

#### Checkout

This stage checks out the code from the Git repository using the git command.

#### Build

This stage builds a Docker image using the deploy.sh script. The script sets execute permissions, changes ownership, and then stops and removes any existing containers before building the Docker image. Once the image is built, the script runs a container using the image.

#### Dockerfile

The Dockerfile defines the Docker image used in the pipeline. It uses the latest version of the Nginx base image, copies the index.html file to the appropriate directory, exposes port 8081, and starts the Nginx server.

#### Validation

After the Docker container is started, the pipeline runs a validation step to ensure that the website is accessible. The step uses the curl command to check if the website is accessible at http://localhost. If the website is not accessible, the pipeline stops the container and exits with an error.

#### Webhook

To trigger the Jenkins pipeline automatically on each new commit, a webhook is set up in the GitHub repository. Here are the steps to set up the webhook:

- Go to your GitHub repository and click on "Settings".
- Click on "Webhooks" in the left-hand menu.
- Click on the "Add webhook" button.
- In the "Payload URL" field, enter the URL of your Jenkins server followed by "/github-webhook/" (e.g., http://your-jenkins-server/github-webhook/).
- In the "Content type" field, select "application/json".
- In the "Which events would you like to trigger this webhook?" section, select "Just the push event".
- Click on the "Add webhook" button.

Once the webhook is set up, the Jenkins pipeline will be triggered automatically on each new commit to your GitHub repository.


# Architectural Design Pattern Documentation

- The overall architecture of the pipeline consists of four main components: the GitHub repository, the Build server (Jenkins), Docker, and the web application itself. These components work together to automate the deployment of the web application.

- The GitHub repository is where the source code for the web application is stored. Whenever a new commit is made to the repository, a webhook is triggered, which sends a notification to the Jenkins server.

- The Jenkins server is responsible for running the pipeline. The pipeline is defined in the Jenkinsfile, which contains the stages and steps required to build and deploy the web application. The pipeline is triggered automatically by the webhook when a new commit is made to the repository.

- The first stage of the pipeline is the checkout stage, which checks out the source code from the GitHub repository. The second stage is the build stage, which builds a Docker image using the deploy.sh script. The script sets execute permissions, changes ownership, and then stops and removes any existing containers before building the Docker image. Once the image is built, the script runs a container using the image.

- The Docker image is defined in the Dockerfile. The Dockerfile specifies the base image, which in this case is the latest version of Nginx. It also copies the index.html file to the appropriate directory, exposes port 8081, and starts the Nginx server.

- The final stage of the pipeline is the validation stage, which ensures that the website is accessible. The pipeline uses the curl command to check if the website is accessible at http://localhost. If the website is not accessible, the pipeline stops the container and exits with an error.

Overall, this pipeline automates the process of building and deploying the web application by integrating the GitHub repository, Jenkins server, Docker, and the web application itself. This automated process reduces the risk of human errors and ensures that the web application is deployed consistently and reliably. 


## Flowchart that illustrates the process:


+------------------+                     +---------------------+                     
|  GitHub          |                     | Jenkins             |                     
|  Repository      |                     | Pipeline            |                     
+------------------+                     +---------------------+                     
         |                                       |                                   
         | 1. Push commit to repository           |                                   
         V                                       V                                   
+------------------+                     +---------------------+                     
|  GitHub Webhook  |                     |  Jenkins Job        |                     
|  (Push Event)    |                     |  (Jenkinsfile)      |                     
+------------------+                     +---------------------+                     
         |                                       |                                   
         | 2. Trigger Jenkins pipeline           |                                   
         V                                       V                                   
+------------------+                     +---------------------+                     
|  Build Server    |                     | Docker              |                     
|  (Jenkins)       |                     |                     |                     
+------------------+                     +---------------------+                     
         |                                       |                                   
         | 3. Checkout code from repository      |                                   
         V                                       |                                   
+------------------+                              |                                   
|  Git Repository   |                              |                                   
+------------------+                              |                                   
         |                                       |                                   
         | 4. Build Docker image using            |                                   
         |    deploy.sh script                    |                                   
         V                                       |                                   
+------------------+                              |                                   
|  Docker           |                              |                                   
+------------------+                              |                                   
         |                                       |                                   
         | 5. Deploy Docker image to container    |                                   
         V                                       |                                   
+------------------+                              |                                   
|  Docker Container |                              |                                   
+------------------+                              |                                   
         |                                       |                                   
         | 6. Validate that website is            |                                   
         |    accessible                          |                                   
         V                                       |                                   
+------------------+                              |                                   
|  curl             |                              |                                   
+------------------+                              |                                   
         |                                       |                                   
         | 7. Exit pipeline with success or error |                                   
         V                                       V                                   
+------------------+                     +---------------------+                     
|  GitHub          |                     | Jenkins             |                     
|  Repository      |                     | Pipeline            |                     
+------------------+                     +---------------------+                     



- This flowchart shows the various steps involved in the pipeline, including pushing a commit to the GitHub repository, triggering the Jenkins pipeline through a webhook, checking out the code from the repository, building a Docker image using the deploy.sh script, deploying the Docker image to a container, validating that the website is accessible, and exiting the pipeline with success or error.

- The components involved in the pipeline include the GitHub repository, the GitHub webhook, the Jenkins server, the Jenkins pipeline (defined in the Jenkinsfile), the Git repository (used for checking out code), Docker (used for building and deploying the Docker image), and curl (used for validating the website).


# Documentation for Automating the Stand Up of the Webserver

This document describes the steps required to automate the stand up of a webserver using a Jenkins pipeline and Docker.

### Pre-requisites
A Jenkins server running on a Linux machine
Docker installed on the Jenkins server
### Configuration
1. Install the necessary Jenkins plugins:
- Docker Pipeline plugin
- GitHub plugin
- Pipeline plugin
2. Set up a webhook in the GitHub repository to trigger the Jenkins pipeline on each new commit. Refer to the "Webhook" section in the README for detailed steps.
3. Create a Jenkins pipeline project and configure it with the following settings:
- Pipeline script from SCM
- SCM: Git
- Repository URL: https://github.com/padnin/Resume.git
- Script Path: Jenkinsfile
### Pipeline Steps
The pipeline performs the following steps:
#### Checkout
This stage checks out the code from the Git repository using the git command.
  stage('checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-jenkins-PAT', url: 'https://github.com/padnin/Resume.git'
            }
        }
#### Build, Deploy and Validation

This stage performs build, deploy and validation using a deploy.sh script. This script sets execute permissions, changes ownership, and then stops and removes any existing containers before building the Docker image. Once the image is built, the script runs a container using the image and then validates to ensure that the website is accessible. The step uses the curl command to check if the website is accessible at http://localhost. If the website is not accessible, the pipeline stops the container and exits with an error.
stage('Build, Deploy & Validate') {
            steps {
                script {
                    try {
                        sh './deploy.sh'
                    } catch (Exception e) {
                        currentBuild.result = "FAILURE"
                        throw e 
                    }
                }
            }
        }
Catch and throw blocks are used in each stage of this pipeline to handle errors and exceptions that may occur during the pipeline execution, also to have a better control on the flow of pipeline, handle errors and exceptions gracefully, and provide meaningful feedback to the user.

### Conclusion
By following the steps outlined in this document, we can automate the stand up of a webserver using a Jenkins pipeline and Docker. This enables to quickly and easily deploy and validate changes to the web application.