### Simulate servers
Simulate servers using python HTTP servers on different ports

Port 8000
```
python3 -m http.server 8000 &
```{{exec}}

Port 8001
```
python3 -m http.server 8001 &
```{{exec}}

```
touch inventory.ini
```{{exec}}

```
cat <<EOF >> inventory.ini 
[missile_launch]
localhost ansible_port=8000 ansible_host=127.0.0.1 ansible_connection=local

[disaster_recovery]
localhost ansible_port=8001 ansible_host=127.0.0.1 ansible_connection=local EOF
```{{exec}}

