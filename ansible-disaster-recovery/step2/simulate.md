### Simulate the Local Environment
First of all, we need to create an Ansible inventory file. This file is a configuration file that defines the hosts and groups of hosts (with their connection details) that Ansible manages and executes tasks on.

```
touch inventory.ini
```{{exec}}

Now, let's edit the inventory file to tell Ansible that we are working on the local machine (localhost).

We will use the cat commande to write directly to the file.
```
cat <<EOF >> inventory.ini 
[missile_server]
missile_server ansible_connection=local
EOF
```{{exec}}

