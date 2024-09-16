### Set Up SSH Access to Managed Nodes
Configure SSH access between the control node and other managed nodes. This step ensures Ansible can communicate with the managed servers without manual login.
```
ssh-keygen -t rsa -b 4096
```{{exec}}

```
ssh-copy-id user@server-ip
```{{exec}}