#!/bin/bash

# Run the Docker container (Deploy)
docker run -d -p 8081:80 --name resume-hosting resume-hosting

# Check if the website is accessible (validation )

if curl --output /dev/null --silent --head --fail http://localhost; then
                                echo "Website is accessible."
                            else
                                echo "Website is not accessible. Exiting."
                                docker stop resume-website
                                exit 1
                            fi