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
docker run -d --name missile_server -p 80:80 -v $(pwd)/html:/usr/share/nginx/html nginx:alpine
```

```
- hosts: missile_server
  become: yes
  tasks:
    - name: Create directory for HTML files
      file:
        path: /usr/share/nginx/html
        state: directory
        mode: '0755'

    - name: Copy test file to NGINX server
      copy:
        content: |
          This is a test file.
        dest: /usr/share/nginx/html/test.txt
        mode: '0644'
```
We can use Ad-hoc commands to run scripts:
```
ansible missile_server -i inventory.ini -m command -a "/usr/share/nginx/html/abort_missile.sh" --become
```


[ACCESS NGINX]({{TRAFFIC_HOST1_80}})
```
docker run -d -p 80:80 --name command_server nginx:alpine
```


[missile_server]
command_server ansible_connection=docker


docker run -d --name command_server -p 80:80 nginx:alpine /bin/sh -c "apk add --no-cache python3 && tail -f /dev/null"

docker run -d --name command_server -p 80:80 nginx:alpine /bin/sh -c "apk add --no-cache python3 py3-pip && pip3 install --upgrade pip && pip3 install ansible && tail -f /dev/null"

docker run -d --name command_server -p 80:80 -u 1000:1000 nginx:alpine /bin/sh -c "apk add --no-cache python3 py3-pip && pip3 install ansible && tail -f /dev/null"



#!/bin/bash
echo "Hello from Ansible!"

---
- name: Setup Nginx Docker Container
  hosts: command_server
  become: yes
  tasks:
    - name: Copy bash script to the server
      copy:
        src: message.sh
        dest: /tmp/message.sh
        mode: '0755'

    - name: Run the bash script on the server
      command: /tmp/message.sh

    - name: Install Nginx (if not already installed)
      apt:
        name: nginx
        state: present
      when: ansible_os_family == "Debian"

    - name: Start Nginx service
      service:
        name: nginx
        state: started


---
- name: Configure Nginx Server
  hosts: command_server
  tasks:
    - name: Copy bash script to the server
      copy:
        src: message.sh
        dest: /tmp/message.sh
        mode: '0755'

    - name: Run the bash script on the server
      shell: /tmp/message.sh
      register: script_output

    - name: Display the output of the script
      debug:
        var: script_output.stdout

ansible-playbook -i inventory.ini command_server.yml


---------------------------- TESTA DET HÄR HUGO:
docker run -d -p 80:80 --name command_server nginx:alpine


(För att gå in i containern, behövs inte göras)
docker exec -it command_server /bin/sh

inventory.ini:
[command_server]
command_server ansible_connection=local

command_server.yml:
---
- name: Configure Nginx Server
  hosts: command_server
  gather_facts: no
  tasks:
    - name: Copy bash script with debugging and stderr redirection to the server
      raw: |
        docker exec -i command_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        echo \"Hello from Ansible!\" >&2' > /root/message.sh &&
        chmod +x /root/message.sh"

docker exec -i command_server /bin/sh /root/message.sh


<!-- ---
- name: Configure Nginx Server
  hosts: command_server
  gather_facts: no
  tasks:
    - name: Copy bash script with debugging and stderr redirection to the server
      raw: docker exec -i command_server /bin/sh -c "echo -e '#!/bin/sh\n \necho \"Hello from Ansible!\" >&2' > /root/message.sh && chmod +x /root/message.sh"

    - name: Verify script exists inside the container
      raw: docker exec -i command_server ls -l /root/message.sh

    - name: Display contents of the script
      raw: docker exec -i command_server cat /root/message.sh

    - name: Run the bash script on the server with output redirection
      raw: docker exec -i command_server /bin/sh /root/message.sh
 -->

 ---
- name: Configure Command Server
  hosts: command_server



   tasks:
    - name: Create launch missile script
      raw: |
        docker exec -i command_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        sleep 1
        echo \"Launching missile...\" >&2' > /root/launch_missile.sh &&
        chmod +x /root/launch_missile.sh"



    - name: Abort missile script (under maintenance on Command Server)
      raw: |
        docker exec -i command_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        sleep 1
        echo \"Under maintenance, please switch to the backup server.\" >&2' > /root/abort_missile.sh &&
        chmod +x /root/abort_missile.sh"


Kör scriptet:
docker exec -i command_server /bin/sh /root/launch_missile.sh
docker exec -i command_server /bin/sh /root/abort_missile.sh


---
- name: Configure Backup Server
  hosts: missile_server
  become: yes
  tasks:
    - name: Create launch missile script
      raw: |
        docker exec -i command_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        sleep 1
        echo \"Launching missile...\" >&2' > /root/launch_missile.sh &&
        chmod +x /root/launch_missile.sh"

    - name: Abort missile script on backup server
      raw: |
        docker exec -i command_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        sleep 1
        echo \"Missile launch aborted successfully!\" >&2' > /root/abort_missile.sh &&
        chmod +x /root/abort_missile.sh"

----------------------------




Stop and Clean Up Containers
```
docker stop missile_server
docker rm missile_server
```
