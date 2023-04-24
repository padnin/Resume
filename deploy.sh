#!/bin/bash

# Set execute permissions for the script
chmod +x $0

# Change ownership of the script to the current user
chown $(whoami) $0

# Stop and remove any existing containers
docker stop resume-hosting || true && docker rm resume-hosting || true

# Build the Docker image
docker build -t resume-hosting .

# Run the Docker container (Deploy)
docker run -d -p 8082:80 --name resume-hosting resume-hosting

# Check if the website is accessible (validation )

if curl --output /dev/null --silent --head --fail http://localhost; then
                                echo "Website is accessible."
                            else
                                echo "Website is not accessible. Exiting."
                                docker stop resume-hosting
                                exit 1
                            fi