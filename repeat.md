Instead of starting python server:

```
nano Dockerfile
```

```
# Use a basic image like Ubuntu or Alpine
FROM ubuntu:20.04

# Install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    vim \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy missile server files (if any)
# COPY /local/path/to/files /path/in/container

# Expose any necessary ports
EXPOSE 8000

# Set a default command
CMD ["sleep", "infinity"]
```


```
docker build -t missile_server_image .
```

```
docker run -d --name missile_server -p 8000:80 missile_server_image
```

Find IP address
```
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' missile_server
```

```
nano inventory.ini
```

```
[missile_server]
missile_server ansible_host=<container_ip> ansible_user=root ansible_connection=docker
```

```
touch backup_server.yml
```

```
---
- hosts: missile_server
  become: yes
  tasks:
    - name: Create launch missile script
      copy:
        content: |
          #!/bin/bash
          sleep 1
          echo "Launching missile..."
          # Missile launch logic
        dest: /tmp/launch_missile
        mode: '0755'
```

```
ansible-playbook -i inventory.ini backup_server.yml
```


Kinda works:
default.conf file
```
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
```

```
docker run -d --name missile_server -p 8000:80 -v $(pwd)/html:/usr/share/nginx/html nginx:alpine
```



Stop and Clean Up Containers
```
docker stop missile_server
docker rm missile_server
```
