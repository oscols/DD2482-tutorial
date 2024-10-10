### Configure the servers using Ansible




```
touch launch.yml
```{{exec}}

```
cat <<EOF >> launch.yml
---
- hosts: command_server
  become: yes
  tasks:
    - name: Install Nginx on command server
      apt:
        name: nginx
        state: present
    - name: Start Nginx service on command server
      service:
        name: nginx
        state: started
    - name: Enable missile launch on command server
      copy:
        content: |
          #!/bin/bash
          echo "Launching missile..."

    - name: Implement abort launch on command server
      copy:
        content: |
          #!/bin/bash
          echo "Not implemented yet, please switch to the backup server."
EOF
```{{exec}}

```
touch recovery.yml
```{{exec}}

```
cat <<EOF >> recovery.yml
---
- hosts: backup_server
  become: yes
  tasks:
    - name: Install Nginx on backup server
      apt:
        name: nginx
        state: present
    - name: Start Nginx service on backup server
      service:
        name: nginx
        state: started
    - name: Implement abort missile launch on backup server
      copy:
        content: |
          #!/bin/bash
          echo "Missile launch aborted successfully!"
EOF
```{{exec}}