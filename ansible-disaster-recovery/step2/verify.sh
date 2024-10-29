if ! (grep -q "[missile_server]" inventory.ini && grep -q "ansible_connection=local" inventory.ini); then
  exit 1
fi