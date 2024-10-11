### Configure the servers using Ansible

```
cat <<EOF >> launch.yml
---
- hosts: missile_server
  become: yes
  tasks:
    - name: Create launch missile script
      copy:
        content: |
          #!/bin/bash
          echo "Launching missile..."
          # Missile launch logic
        dest: /usr/local/bin/launch_missile
        mode: '0755'

    - name: Run missile launch script
      command: /usr/local/bin/launch_missile

    - name: Create abort missile script (not implemented on command server)
      copy:
        content: |
          #!/bin/bash
          echo "Not implemented yet, please switch to the backup server."
        dest: /usr/local/bin/abort
        mode: '0755'
EOF
```{{exec}}

```
cat <<EOF >> recovery.yml
---
- hosts: missile_server
  become: yes
  tasks:
    - name: Create abort missile script on backup server
      copy:
        content: |
          #!/bin/bash
          echo "Missile launch aborted successfully!"
        dest: /usr/local/bin/abort
        mode: '0755'
EOF
```{{exec}}