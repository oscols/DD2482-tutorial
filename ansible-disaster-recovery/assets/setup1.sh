#!/bin/bash

# Container name
CONTAINER_NAME="command_server"

# Step 1: Create /root/secret directory in the container
echo "Creating /root/secret directory in the container..."
docker exec -i "$CONTAINER_NAME" /bin/sh -c "mkdir -p /root/secret"