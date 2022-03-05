#this file should live in /root/
# run "chmod +x restart-node.sh" to make this file executable
# kill paw_node
killall paw_node

# start paw_node
/usr/local/bin/paw_node --daemon &

# wait 10 seconds and try to start again. The process knows to auto-exit if another copy is already running.
sleep 10
/usr/local/bin/paw_node --daemon &

#send some helpful stats to paw.log
sleep 10
date +"%F %T" >> /root/paw.log
curl -g -d '{ "action": "block_count"}' [::1]:7046 >> /root/paw.log