### Configure the servers using Ansible




```
touch launch.yml
```{{exec}}

```
cat <<EOF >> launch.yml
---
- name: Missile Launch System
  hosts: missile_launch
  tasks:
    - name: Notify missile launch system is running
      debug:
        msg: "Missile launch system is running on port {{ ansible_port }}"
EOF
```{{exec}}

```
touch recovery.yml
```{{exec}}

```
cat <<EOF >> recovery.yml
---
- name: Disaster Recovery Backup
  hosts: disaster_recovery
  tasks:
    - name: Notify disaster recovery system is running
      debug:
        msg: "Disaster recovery system is running on port {{ ansible_port }}"
EOF
```{{exec}}