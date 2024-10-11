#!/bin/bash
mkdir -p /usr/local/bin/secret

cat <<EOF >> /usr/local/bin/secret/do_not_run_this_script
#!/bin/bash
sleep 1
echo "WARNING: Changing Target Location"
sleep 0.5
echo "..."
sleep 2
echo "Spoons headquarters"
sleep 0.5
echo "..."
sleep 2
echo "Location will be obliterated within 1 minute"
sleep 0.5
echo "..."
sleep 1
echo "OH NO, WHAT DID YOU DO????"
EOF