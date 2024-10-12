if ! [ -f "launch.yml" ] || ! [ -f "recovery.yml" ] ; then
  exit 1
fi

if ! (grep -q "Launching missile..." launch.yml && grep -q "dest: /usr/local/bin/launch_missile" launch.yml && grep -q "Under maintenance, please switch to the backup server." launch.yml && grep -q "dest: /usr/local/bin/abort" launch.yml); then
  exit 1
fi

if ! (grep -q "Missile launch aborted successfully!" recovery.yml && grep -q "dest: /usr/local/bin/abort" recovery.yml); then
  exit 1
fi