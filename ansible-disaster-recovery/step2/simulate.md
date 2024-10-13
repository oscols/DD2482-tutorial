### Simulate servers
We want to simulate the missile server using a Python HTTP server

For this we will use port 8000
```
python3 -m http.server 8000 &
```{{exec}}

Then we create an Ansible inventory file. This file is a configuration file that defines the hosts and groups of hosts (with their connection details) that Ansible manages and executes tasks on.

```
touch inventory.ini
```{{exec}}

In this case, we just want one server, "missile_server", so we create a group called missile_server that is running on localhost and using port 8000 (The server we just set up). And the connection is local since the server is on the same machine.

```
cat <<EOF >> inventory.ini 
[missile_server]
missile_server ansible_port=8000 ansible_host=127.0.0.1 ansible_connection=local
EOF
```{{exec}}

