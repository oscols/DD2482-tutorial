
### Setting Up the Servers
What the servers are used for
Why we need two servers

Start a docker container for the Command Server 
maps port 80 on the host to port 80 in the container 
We give it a custom name command_server
The base image of the server is Nginx, and we're using the lightweight "Alpine" version.
```
docker run -d -p 80:80 --name command_server nginx:alpine
```{{exec}}


maps port 81 on the host to port 80 in the container 
```
docker run -d -p 81:80 --name backup_server nginx:alpine
```{{exec}}