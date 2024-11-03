### Create an Ansible inventory file
First of all, we need to create an Ansible inventory file. This file is a configuration file that defines the hosts and groups of hosts (with their connection details) that Ansible manages and executes tasks on.

```
touch inventory.ini
```{{exec}}

Now, let's edit the inventory file to create a host group named command_server, defined by `[command_server]`. Within this group, we’ll specify an individual host, `command_server`, and set the connection type to `local`. This tells Ansible that all tasks should be executed on the local machine (localhost), rather than connecting to a remote server.

We also do the same for `backup_server`.

We will use the cat commande to write directly to the file.
```
cat <<EOF >> inventory.ini 
[command_server]
command_server ansible_connection=local

[backup_server]
backup_server ansible_connection=local
EOF
```{{exec}}