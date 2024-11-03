
### Setting Up the Servers
In this secenario, we need a server. The purpose of the server is to be able to send commands, such as launch and abort missile, to the missile system.

Additionally, we will set up a backup server in case something happens with the main server. Since safety is extremely important in military systems. 

For the main server, which we will call `command_server`, we start a Docker container with the following command:
```
docker run -d -p 80:80 --name command_server nginx:alpine
```{{exec}}

What this does, is that it maps port 80 on the host to port 80 in the container.
It gives the container a custom name `command_server`
It also sets the base image of the server to Nginx, and specifying that we will be using the lightweight "Alpine" version.

We do the same thing for the backup server, which we call `backup_server`. But we map port 81 on the host to port 80 in the container:
```
docker run -d -p 81:80 --name backup_server nginx:alpine
```{{exec}}