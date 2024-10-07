### Create a Simple Ansible Playbook
Create a file for your playbook
```
touch playbook.yml
```{{exec}}

Install and configure Ngix on local server
```
cat <<EOF > playbook.yml
---
- hosts: localhost
  become: yes
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
    - name: Start Nginx service
      service:
        name: nginx
        state: started
EOF
```{{exec}}