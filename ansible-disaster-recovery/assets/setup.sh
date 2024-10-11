#!/bin/bash
mkdir -p /home/secret

cat <<EOF >> /home/secret/do_not_run_this_script
#!/bin/bash
echo "OH NO, WHAT DID YOU DO????"
echo "Changing target location to Spoons headquarters"
EOF

chown -R $(whoami):$(whoami) /home/secret