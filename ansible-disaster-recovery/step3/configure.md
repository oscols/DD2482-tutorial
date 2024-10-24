### Configure Ansible Playbooks
Now that we've set up Ansible to work locally, it's time to configure our simulated missile environment by using an Ansible playbook.

First, let's create the playbook that will configure the missile environment.
```
touch command_server.yml
```{{exec}}

Edit the file using Nano
```
nano command_server.yml
```{{exec}}

We want to set the missile server as the host. 
"become: yes" tells Ansible to execute the tasks as a superuser (root)
```
---
- hosts: missile_server
  become: yes
```{{exec}}

Then we want to add some tasks, the first one is creating the launch script for the missile.
"copy" means copy file to remote server, and the content of the file will be the logic to launch the missile, the current code is just a placeholder.
"mode: '0755'" sets the file permission to 0755, which means the owner can do anyting with the script and readable/executable by others.
```
  tasks:
    - name: Create launch missile script
      copy:
        content: |
          #!/bin/bash
          sleep 1
          echo "Launching missile..."
          # Missile launch logic
        dest: /usr/local/bin/launch_missile
        mode: '0755'

```{{exec}}

Then, we want to be able to launch the missile with this task
```
    - name: Run missile launch script
      command: /usr/local/bin/launch_missile

```{{exec}}

Of course, we also want to be able to abort the launch. It is currently under maintenance, but that should be fine since we don't plan on starting any wars in the near future.
```
    - name: Abort missile script (under maintenance on command server)
      copy:
        content: |
          #!/bin/bash
          echo "Under maintenance, please switch to the backup server."
        dest: /usr/local/bin/abort
        mode: '0755'
```{{exec}}

Now, you can write out and exit Nano.

We also want to create a backup in case something goes wrong, as a Disaster Recovery mechanism.
```
touch backup_server.yml
```{{exec}}

Use the same setup as for the command server but with the old abort script.
```
cat <<EOF >> backup_server.yml
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
        dest: /usr/local/bin/launch_missile
        mode: '0755'

    - name: Run missile launch script
      command: /usr/local/bin/launch_missile

    - name: Abort missile script on backup server
      copy:
        content: |
          #!/bin/bash
          echo "Missile launch aborted successfully!"
        dest: /usr/local/bin/abort
        mode: '0755'
EOF
```{{exec}}