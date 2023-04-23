README

This repository contains code for automating the deployment of a web application using a Jenkins pipeline and Docker. The application is a simple static website hosting information about the Resume, and the pipeline performs the following steps:

Checkout: Checkout the code from the repository
Build: Build a Docker image using the code
Deploy: Deploy the Docker image to a container
Validation: Validate that the website is accessible

Pipeline

The Jenkins pipeline is defined in the Jenkinsfile and has two stages:

Checkout

This stage checks out the code from the Git repository using the git command.

Build

This stage builds a Docker image using the deploy.sh script. The script sets execute permissions, changes ownership, and then stops and removes any existing containers before building the Docker image. Once the image is built, the script runs a container using the image.

Dockerfile

The Dockerfile defines the Docker image used in the pipeline. It uses the latest version of the Nginx base image, copies the index.html file to the appropriate directory, exposes port 8081, and starts the Nginx server.

Validation

After the Docker container is started, the pipeline runs a validation step to ensure that the website is accessible. The step uses the curl command to check if the website is accessible at http://localhost. If the website is not accessible, the pipeline stops the container and exits with an error.

Webhook

To trigger the Jenkins pipeline automatically on each new commit, a webhook is set up in the GitHub repository. Here are the steps to set up the webhook:

Go to your GitHub repository and click on "Settings".
Click on "Webhooks" in the left-hand menu.
Click on the "Add webhook" button.
In the "Payload URL" field, enter the URL of your Jenkins server followed by "/github-webhook/" (e.g., http://your-jenkins-server/github-webhook/).
In the "Content type" field, select "application/json".
In the "Which events would you like to trigger this webhook?" section, select "Just the push event".
Click on the "Add webhook" button.

Once the webhook is set up, the Jenkins pipeline will be triggered automatically on each new commit to your GitHub repository.





