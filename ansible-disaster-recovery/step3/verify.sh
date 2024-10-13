if ! [ -f "command_server.yml" ] || ! [ -f "backup_server.yml" ] ; then
  exit 1
fi

if ! (grep -q "Launching missile..." command_server.yml && grep -q "dest: /usr/local/bin/launch_missile" command_server.yml && grep -q "Under maintenance, please switch to the backup server." command_server.yml && grep -q "dest: /usr/local/bin/abort" command_server.yml); then
  exit 1
fi

if ! (grep -q "Missile launch aborted successfully!" backup_server.yml && grep -q "dest: /usr/local/bin/abort" backup_server.yml); then
  exit 1
fi