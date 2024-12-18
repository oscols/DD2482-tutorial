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

We want to set the main server, `command_server`, as the host. 
```
---
- name: Configure Command Server
  hosts: command_server
```{{exec}}

Then we want to add some tasks, the first one is creating the launch script for the missile.
`raw` is used to create the script directly on the container by running shell commands via `docker exec`.
The script file created by this task (/root/launch_missile.sh) is set up to contain the logic for launching a missile. Currently, it’s just a placeholder that outputs a message.
```
  tasks:
    - name: Create launch missile script
      raw: |
        docker exec -i command_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        sleep 1
        echo \"Launching missile...\" >&2' > /root/launch_missile.sh &&
        chmod +x /root/launch_missile.sh"
```{{exec}}

Of course, we also want to be able to abort the launch. It is currently under maintenance, but that should be fine since we don't plan on starting any wars in the near future.
```
    - name: Abort missile script (under maintenance on Command Server)
      raw: |
        docker exec -i command_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        sleep 1
        echo \"Under maintenance, please switch to the backup server.\" >&2' > /root/abort_missile.sh &&
        chmod +x /root/abort_missile.sh"
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
- name: Configure Backup Server
  hosts: backup_server
  become: yes
  tasks:
    - name: Create launch missile script
      raw: |
        docker exec -i backup_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        sleep 1
        echo \"Launching missile...\" >&2' > /root/launch_missile.sh &&
        chmod +x /root/launch_missile.sh"

    - name: Abort missile script on backup server
      raw: |
        docker exec -i backup_server /bin/sh -c "
        echo -e '#!/bin/sh\n
        sleep 1
        echo \"Missile launch aborted successfully!\" >&2' > /root/abort_missile.sh &&
        chmod +x /root/abort_missile.sh"
EOF
```{{exec}}