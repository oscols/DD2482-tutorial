#!/bin/bash
mkdir -p /usr/local/bin/secret/

cat <<EOF >> /usr/local/bin/secret/do_not_run_this_script
#!/bin/bash
sleep 1
echo "Changing target location ..."
sleep 0.5
echo "... to Spoons headquarters"
sleep 1.5
echo "Location will be obliterated within 1 minute"
sleep 0.5
echo "OH NO, WHAT DID YOU DO????"
EOF

chown -R $(whoami):$(whoami) /home/secret