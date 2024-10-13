if ! nc -zv 127.0.0.1 8000 2>&1 | grep -q 'succeeded'; then
  exit 1
fi

if ! (grep -q "[missile_server]" inventory.ini && grep -q "ansible_port=8000" inventory.ini); then
  exit 1
fi