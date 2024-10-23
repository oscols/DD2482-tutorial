if ! (grep -q "[missile_server]" inventory.ini && grep -q "ansible_port=8000" inventory.ini); then
  exit 1
fi