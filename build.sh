#!/bin/bash

# Set execute permissions for the script
chmod +x $0

# Change ownership of the script to the current user
chown $(whoami) $0

# Stop and remove any existing containers
docker stop resume-hosting || true && docker rm resume-hosting || true

# Build the Docker image
docker build -t resume-hosting .
