#!/bin/bash

# Add dispatcher host and dispatcher port to the apache environment variables
# Remove old entries
#sed -i '/export DISPATCHER_HOST=/d' /etc/apache2/envvars
#sed -i '/export DISPATCHER_PORT=/d' /etc/apache2/envvars
    
# Add the current values
#echo "export DISPATCHER_HOST=$DISPATCHER_HOST" >> /etc/apache2/envvars
#echo "export DISPATCHER_PORT=$DISPATCHER_PORT" >> /etc/apache2/envvars

# Remove old entries
#sed -i '/DISPATCHER_HOST=/d' /etc/environment
#sed -i '/DISPATCHER_PORT=/d' /etc/environment
#    
# Add the current values
#echo "DISPATCHER_HOST=$DISPATCHER_HOST" >> /etc/environment
#echo "DISPATCHER_PORT=$DISPATCHER_PORT" >> /etc/environment


# Update number of simultaneous jobs
perl -pi -e "s/\$config\['jobe_max_users'\] = \d+;/\$config\['jobe_max_users'\] = ${SIM_JOBE_JOBS};/" /var/www/html/jobe/application/config/config.php

# Start the Apache web server (in the background)
/usr/sbin/apache2ctl -D FOREGROUND &

# Wait for a short time to ensure the webserver is up
sleep 10

# Reinstall jobe so that the changes to the configuration (regarding simultaneous jobs, see the dockerfile) take effect
cd /var/www/html/jobe
./install --purge

# Keep the container running
tail -f /dev/null
