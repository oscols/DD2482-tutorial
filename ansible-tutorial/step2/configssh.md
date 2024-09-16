### Set Up SSH Access to Managed Nodes
Configure SSH access between the control node and other managed nodes. This step ensures Ansible can communicate with the managed servers without manual login
```

Generate a new SSH key pair
ssh-keygen -t rsa -b 4096
```{{exec}}

Press enter when you need to enter a file to save the key and overwrite the exisiting file

Update password for the ubuntu user, since you will need a password to use `ssh-copy-id`
```
sudo passwd ubuntu
```{{exec}}

Set password to something simple, like:
```
123
```{{exec}}

Copy your public SSH key to the remote server's `authorized_keys` file, which will allow you to log in to that server without a password
```
ssh-copy-id ubuntu@localhost
```{{exec}}