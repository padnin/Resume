#!/bin/bash

# Set execute permissions for the script
chmod +x $0

# Change ownership of the script to the current user
chown $(whoami) $0

# Stop and remove any existing containers
docker stop resume-website || true && docker rm resume-website || true

# Build the Docker image
docker build -t resume-website .

# Run the Docker container
docker run -d -p 8081:80 --name resume-website resume-website

# Check if the website is accessible
status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost)
if [[ $status_code -ne 200 ]]; then
    echo "Website is not accessible. Exiting."
    docker stop resume-website
    exit 1
fi
